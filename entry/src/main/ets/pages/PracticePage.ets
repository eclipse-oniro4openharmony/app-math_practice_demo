@Entry
@Component
struct PracticePage {
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
        Text('1+1=?')
          .wordStyle()
        Text('"Unbelievable or not, it happened, unbelievable or not, it happened"')
          .sampleSentenceStyle()
      }

      //Options
      Column({ space: 10 }) {
        ForEach([1, 2, 3, 4], (options: number) => {
          Button(options.toString())
            .optionButtonStyle(
              Color.White,
              Color.Green
            )
        })
      }

      //Control buttons
      Row({space:50}) {
        Button('End')
          .controlButtonStyle(
            Color.Transparent,
            Color.Black,
            Color.Black
          )
        Button('Start')
          .controlButtonStyle(
            Color.Black,
            Color.White,
            Color.Black
          )
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