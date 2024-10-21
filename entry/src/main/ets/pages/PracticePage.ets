import { AnswerStatus } from '../enums/AnswerStatus'
import { PracticeStatus } from '../enums/PracticeStatus'
import { getRandomQuestions, Question } from '../model/Questions'
import  promptAction  from '@ohos.promptAction'

@Entry
@Component
struct PracticePage {
  @State practiceStatus: PracticeStatus = PracticeStatus.Stopped
  @State questions: Question[] = getRandomQuestions(3)
  @State currentIndex: number = 0;
  @State clickable:boolean = true;
  @State answerStatus: AnswerStatus = AnswerStatus.Answering

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
          Button(option)
            .optionButtonStyle(
              Color.White,
              Color.Green
            )
            .onClick(()=>{
              if(this.practiceStatus !== PracticeStatus.Running){
                  promptAction.showToast({
                    message:'Please click start to practice'
                  })
                return
              }
              // to do: wrong or correct

              // to do: update summary information

              if(this.currentIndex < this.questions.length-1)
              {
                this.answerStatus = AnswerStatus.Answered
                setTimeout(()=>{
                  this.clickable = false;
                  this.currentIndex++;
                  this.answerStatus = AnswerStatus.Answering
                },500)//0.5s
              }
              else{
                //end the practice
                this.stopPractice()
              }
            })
            //Options buttion is active when the user is answering
            .enabled(this.answerStatus === AnswerStatus.Answering)
        })
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