import { AnswerStatus } from '../enums/AnswerStatus'
import { PracticeStatus } from '../enums/PracticeStatus'
import { getRandomQuestions, Question } from '../model/Questions'
import promptAction from '@ohos.promptAction'
import { OptionStatus } from '../enums/OptionStatus'

@Entry
@Component
struct PracticePage {
  @State practiceStatus: PracticeStatus = PracticeStatus.Stopped
  @State questions: Question[] = getRandomQuestions(3)
  @State currentIndex: number = 0
  @State answerStatus: AnswerStatus = AnswerStatus.Answering
  @State selectedOption: string = ''

  startPractice() {
    this.practiceStatus = PracticeStatus.Running
    //start timer
  }

  pausePractice() {
    this.practiceStatus = PracticeStatus.Paused
    //stop timer
  }

  stopPractice() {
    this.practiceStatus = PracticeStatus.Stopped
    //pause timer
    //pop window
  }

  build() {
    Column() {
      //Statistic Summary
      Column() {
        Text('Info')
        Text('Info')
        Text('Info')
        Text('Info')
      }
      .summaryStyle()

      //Problem
      Column() {
        Text(this.questions[this.currentIndex].problem)
          .wordStyle()
        Text('"Unbelievable or not, it happened, unbelievable or not, it happened"')
          .sampleSentenceStyle()
      }

      //Options
      Column({ space: 10 }) {
        ForEach(this.questions[this.currentIndex].options, (option: string) => {
          OptionButton({
            option: option,
            answerStatus: this.answerStatus,
            answer: this.questions[this.currentIndex].answer,
            selectedOption: this.selectedOption,
          })
            .onClick(() => {
              if (this.practiceStatus !== PracticeStatus.Running) {
                promptAction.showToast({
                  message: 'Please click start to practice'
                })
                return
              }
              // to do: wrong or correct
              this.selectedOption = option
              // to do: update summary information

              if (this.currentIndex < this.questions.length - 1) {
                this.answerStatus = AnswerStatus.Answered
                setTimeout(() => {
                  this.currentIndex++;
                  this.answerStatus = AnswerStatus.Answering
                }, 500) //0.5s
              }
              else {
                //end the practice
                this.stopPractice()
              }
            })//Options buttion is active when the user is answering
            .enabled(this.answerStatus === AnswerStatus.Answering)
        },
          (option: string) => {
            //Each problem changing we need to ensure not overuse previous button component
            return this.questions[this.currentIndex].problem + '-' + option
          }
        )
      }

      //Control buttons
      Row({ space: 50 }) {
        Button('End')
          .controlButtonStyle(
            Color.Transparent,
            this.practiceStatus === PracticeStatus.Stopped ? Color.Gray : Color.Black,
            this.practiceStatus === PracticeStatus.Stopped ? Color.Gray : Color.Black,
          )
          .enabled(this.practiceStatus !== PracticeStatus.Stopped)
          .onClick(() => {
            this.stopPractice()
          })
        Button(this.practiceStatus === PracticeStatus.Running ? 'Pause' : 'Start')
          .controlButtonStyle(
            this.practiceStatus === PracticeStatus.Running ? Color.Gray : Color.Black,
            Color.White,
            this.practiceStatus === PracticeStatus.Running ? Color.Gray : Color.Black,
          )
          .onClick(() => {
            //to do: start practice
            if (this.practiceStatus === PracticeStatus.Stopped) {
              this.startPractice()
            }
            else {
              this.pausePractice()
            }
          })
      }
    }
    .practiceBgStyle()
  }
}

@Component
struct OptionButton {
  option: string;
  answer: string;
  @State optionStatus: OptionStatus = OptionStatus.Default
  @Prop selectedOption: string = ''
  @Prop @Watch('onAnswerStatusChange') answerStatus: AnswerStatus

  onAnswerStatusChange() {
    if (this.option === this.answer) {
      this.optionStatus = OptionStatus.Correct
    } else {
      if (this.option === this.selectedOption) {
        this.optionStatus = OptionStatus.Wrong
      } else {
        this.optionStatus = OptionStatus.Default
      }
    }
  }

  getBgColor() {
    switch (this.optionStatus) {
      case OptionStatus.Correct:
        return Color.Green
      case OptionStatus.Wrong:
        return Color.Red
      default:
        return Color.White
    }
  }

  build() {
    Stack() {
      Button(this.option)
        .optionButtonStyle(
          this.getBgColor(),
          this.optionStatus === OptionStatus.Default ? Color.Black : Color.White
        )
      if (this.optionStatus === OptionStatus.Correct) {
        Image($r('app.media.correct'))
          .width(22)
          .height(22)
          .offset({ x: 10 })
      }
      else if (this.optionStatus === OptionStatus.Wrong) {
        Image($r('app.media.wrong'))
          .width(22)
          .height(22)
          .offset({ x: 10 })
          .backgroundColor(Color.Black)
      }
    }
    .alignContent(Alignment.Start)
  }
}

@Extend(Column)
function practiceBgStyle() {
  .width('100%')
  .height('100%')
  .backgroundColor('#ff19a2b8')
  //Ensure each component is evenly distributed in horizontal axis
  .justifyContent(FlexAlign.SpaceEvenly)
}

@Styles
function summaryStyle() {
  .backgroundColor(Color.White)
  .width('90%')
  .borderRadius(10)
  .padding(20)
}

@Extend(Text)
function wordStyle() {
  .fontSize(50)
  .fontWeight(FontWeight.Bold)
}

@Extend(Text)
function sampleSentenceStyle() {
  .fontSize(16)
  .fontWeight(FontWeight.Medium)
  .width('80%')
  .textAlign(TextAlign.Center)
  .fontColor('#75100d03')
}

@Extend(Button)
function optionButtonStyle(bgColor: ResourceColor, fontColor: ResourceColor) {
  .backgroundColor(bgColor)
  .fontColor(fontColor)
  .width('80%')
  .height(48)
  .fontSize(20)
}

@Extend(Button)
function controlButtonStyle(
  bgColor: ResourceColor,
  fontColor: ResourceColor,
  borderColor: ResourceColor
) {
  .fontSize(20)
  .fontColor(fontColor)
  .backgroundColor(bgColor)
  .borderColor(borderColor)
  .borderWidth(1)
}