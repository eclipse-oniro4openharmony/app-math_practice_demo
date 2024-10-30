import { AnswerStatus } from '../enums/AnswerStatus'
import { PracticeStatus } from '../enums/PracticeStatus'
import { generateRandomQuestions, Question } from '../model/Questions'
import promptAction from '@ohos.promptAction'
import { OptionStatus } from '../enums/OptionStatus'
import { convertMillisecondsToTime } from '../utils/DateUtil'
import router from '@ohos.router';
import systemDateTime from '@ohos.systemDateTime';
import { generatePunchRecord, PostInfo } from '../model/PostInfo'

@Component
export struct PracticePage {
  @State practiceStatus: PracticeStatus = PracticeStatus.Stopped
  @State totalCount: number = 10
  // @State questions: Question[] = getRandomQuestions(this.totalCount)
  @State questions: Question[] = generateRandomQuestions(this.totalCount)
  @State currentIndex: number = 0
  @State answerStatus: AnswerStatus = AnswerStatus.Answering
  @State selectedOption: string = ''
  @State answeredCount: number = 0
  @State correctCount: number = 0
  timerController: TextTimerController = new TextTimerController()
  timeUsed: number = 0
  dialogController: CustomDialogController = new CustomDialogController({
    builder: ResultDialog({
      answeredCount: this.answeredCount,
      correctCount: this.correctCount,
      timeUsed: this.timeUsed,
      resetPractice: () => {
        //reset the problem sources
        this.questions = generateRandomQuestions(this.totalCount)
        this.currentIndex = 0
        this.answeredCount = 0
        this.timeUsed = 0
        this.correctCount = 0
        this.timerController.reset()
        this.answerStatus = AnswerStatus.Answering
      },
      startPractice: () => {
        this.startPractice()
      }
    }),
    customStyle: true,
    autoCancel: false,
  })
  problemNumDialogController: CustomDialogController = new CustomDialogController({
    builder: ProblemNumberDialog({
      problemNumber: this.totalCount,
      confirm: (value) => {
        this.totalCount = value
        this.questions = generateRandomQuestions(this.totalCount)
      }
    }),
    customStyle: true,
    autoCancel: false,
  })

  startPractice() {
    this.practiceStatus = PracticeStatus.Running
    this.timerController.start()
  }

  pausePractice() {
    this.practiceStatus = PracticeStatus.Paused
    this.timerController.pause()
  }

  stopPractice() {
    this.practiceStatus = PracticeStatus.Stopped
    this.timerController.pause()
    this.dialogController.open()
  }

  build() {
    Column() {
      //Statistic Summary
      Column() {
        SummaryItem({
          icon: $r('app.media.accuracy'),
          name: $r('app.string.Accuracy'),
          fontColor: Color.Black,
        }) {
          Text(this.answeredCount === 0 ?
            '0%' : (this.correctCount / this.answeredCount * 100).toFixed() + '%')
            .width(100)
            .textAlign(TextAlign.Center)
        }

        SummaryItem({
          icon: $r('app.media.speed'),
          name: $r('app.string.Progress'),
          fontColor: Color.Black,
        }) {
          Progress({
            value: this.answeredCount,
            total: this.totalCount
          })
            .width(100)
        }

        SummaryItem({
          icon: $r('app.media.number'),
          name: $r('app.string.Number'),
          fontColor: Color.Black,
        }) {
          Button(this.totalCount.toString())
            .width(100)
            .height(25)
            .backgroundColor('#ff591791')
            .fontColor(Color.White)
            .enabled(this.practiceStatus === PracticeStatus.Stopped)
            .onClick(() => {
              // TextPickerDialog.show({
              //   range: ['5', '10', '15', '20', '25', '30'],
              //   value: this.totalCount.toString(),
              //   onAccept: (result) => {
              //     this.totalCount = parseInt(result.value.toString())
              //     this.questions = generateRandomQuestions(this.totalCount)
              //   }
              // })
              this.problemNumDialogController.open()
            })
        }

        SummaryItem({
          icon: $r('app.media.timer'),
          name: $r('app.string.Time'),
          fontColor: Color.Black,
        }) {
          Row() {
            TextTimer({
              controller: this.timerController
            })
              .onTimer((utc, elapsedTime) => {
                this.timeUsed = elapsedTime
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }

      }
      .summaryStyle()

      //Problem
      Column() {
        Text(this.questions[this.currentIndex].problem)
          .wordStyle()
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
                  message: $r('app.string.Click_start'),
                  bottom: 30
                })
                return
              }
              // todo: wrong or correct
              this.selectedOption = option
              // todo: update summary information
              this.answeredCount++
              if (option === this.questions[this.currentIndex].answer) {
                this.correctCount++
              }

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
        Button($r('app.string.End'))
          .controlButtonStyle(
            Color.Transparent,
            this.practiceStatus === PracticeStatus.Stopped ? Color.Gray : Color.Black,
            this.practiceStatus === PracticeStatus.Stopped ? Color.Gray : Color.Black,
          )
          .enabled(this.practiceStatus !== PracticeStatus.Stopped)
          .onClick(() => {
            this.stopPractice()
          })
        Button(this.practiceStatus === PracticeStatus.Running ? $r('app.string.Pause') : $r('app.string.Start'))
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
            else if (this.practiceStatus === PracticeStatus.Running) {
              this.pausePractice()
            }
            else {
              //continue paused practice
              this.startPractice()
            }
          })
      }
    }
    .practiceBgStyle()
  }
}

@CustomDialog
struct ProblemNumberDialog {
  cancel?: () => void
  confirm?: (num: number) => void
  controller: CustomDialogController
  problemNumber: number = 0

  build() {
    Column() {

      TextInput({ placeholder: $r('app.string.Enter_problem_number') })
        .fontSize(15)
        .margin({ top: 10, bottom: 10 })
        .type(InputType.Number)
        .borderRadius(10)
        .onChange((value) => {
          this.problemNumber = parseInt(value)
        })
        .width(230)
        .height(40)

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button($r('app.string.Cancel'))
          .onClick(() => {
            this.controller.close()
            if (this.cancel) {
              this.cancel()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Black)

        Button($r('app.string.Confirm'))
          .onClick(() => {
            this.controller.close()
            if (this.confirm) {
              this.confirm(this.problemNumber)
            }
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }
      .margin({ bottom: 10 })
      .width(260)
    }
    .backgroundColor(Color.White)
    .borderRadius(20)
  }
}

// 创建全局UI存储
AppStorage.setOrCreate<PostInfo[]>("records", []);
AppStorage.setOrCreate<number>("record_id", 0);

@CustomDialog
struct ResultDialog {
  answeredCount!: number;
  correctCount!: number;
  timeUsed!: number;
  resetPractice!: () => void;
  startPractice!: () => void;
  defaultId: number = 0;
  @StorageLink("records") records: PostInfo[] = [];
  @StorageLink("record_id") record_id: number = 0;
  controller: CustomDialogController = new CustomDialogController({
    builder: ResultDialog()
  })

  build() {
    Column() {
      Column() {
        Image($r('app.media.finish'))
          .width('100%')
          .borderRadius(10)
        SummaryItem({
          icon: $r('app.media.timer'),
          name: 'Time',
          fontColor: Color.Black
        }) {
          Text(convertMillisecondsToTime(this.timeUsed))
        }

        SummaryItem({
          icon: $r('app.media.accuracy'),
          name: 'Accuracy',
          fontColor: Color.Black
        }) {
          Text((this.answeredCount === 0 ? 0 : this.correctCount / this.answeredCount * 100).toFixed() + '%')
        }

        SummaryItem({
          icon: $r('app.media.number'),
          name: 'Number',
          fontColor: Color.Black
        }) {
          Text(this.answeredCount.toString())
        }

        Divider()
          .color(Color.Black)
          .strokeWidth(1)
        Row({ space: 15 }) {
          Button() {
            Text($r('app.string.More_practice'))
              .fontSize(10)
          }
          .onClick(() => {
            this.controller.close()
            this.resetPractice()
            //start new practice
            this.startPractice()
          })
          .controlButtonStyle(
            Color.Transparent,
            Color.Black,
            Color.Black,
          )
          .width('30%')
          .height(40)

          Button() {
            Text($r('app.string.Punch'))
              .fontSize(10)
          }
          .onClick(() => {
            this.controller.close()
            this.resetPractice()
            let record = generatePunchRecord(
              this.record_id++,
              this.correctCount,
              this.answeredCount,
              this.timeUsed,
            )
            this.records.push(record)
            AppStorage.setOrCreate("records", this.records);
            AppStorage.setOrCreate("record_id", this.record_id);
            // console.info(`${ss.timeUsed}`)
            // console.info(`${this.record_id}`)
            // router.pushUrl({ url: "pages/LoginPage" })

            // pop up window show punch successful information
            promptAction.showToast({
              message: $r('app.string.Punch_success'),
              bottom: 30
            })
          })
          .controlButtonStyle(
            Color.Black,
            Color.White,
            Color.Black,
          )
          .width('30%')
          .height(40)

          Button() {
            Text($r('app.string.Finish'))
              .fontSize(10)
          }
          .onClick(() => {
            this.controller.close()
            this.resetPractice()
          })
          .controlButtonStyle(
            '#f80b87ae',
            Color.White,
            Color.White,
          )
          .width('30%')
          .height(40)

        }
        .justifyContent(FlexAlign.Center)
        .margin(20)
      }
      .backgroundColor(Color.White)
      .width('100%')
      .padding(10)
      .borderRadius(10)
      .margin({
        bottom: 85
      })

    }
    .backgroundColor(Color.Transparent)
    .width('80%')
  }
}

@Component
export struct SummaryItem {
  icon!: Resource;
  name!: string | Resource;
  fontColor!: Color;
  @BuilderParam summaryComp: () => void;

  build() {
    Row({ space: 10 }) {
      Image(this.icon)
        .height(30)
        .width(30)
      Text(this.name)
        .fontWeight(FontWeight.Medium)
        .fontSize(14)
        .fontColor(this.fontColor)
      Blank()
      this.summaryComp()
    }
    .width('100%')
    .height(30)
  }
}


@Component
struct OptionButton {
  option!: string;
  answer!: string;
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