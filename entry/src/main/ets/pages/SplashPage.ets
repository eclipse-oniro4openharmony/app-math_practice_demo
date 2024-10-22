import router from '@ohos.router';
@Entry
@Component
struct SplashPage {
  @State flag: boolean = false;

  onPageShow(): void {
    animateTo({
      duration: 1000,
      onFinish:()=>{
        //when the animation finish go the main page
        setTimeout(()=>{
          router.replaceUrl({url: 'pages/Index'})
        }, 200)
      }
    }, () => {
      this.flag = true
    })
  }

  build() {
    Column() {
      if (this.flag) {
        Image($r('app.media.math_icon'))
          .logoStyle()
          .transition({
            type: TransitionType.Insert,
            opacity: 0,
            translate: { x: -150 }
          })
        Text('Practice Math')
          .titleStyle()
          .transition({
            type: TransitionType.Insert,
            opacity: 0,
            translate: { x: 150 }
          })
      }
      Blank()
      Text('OpenHarmony project demo')
        .footerStyle()
    }
    .bgStyle()
  }
}

@Extend(Image)
function logoStyle() {
  .width(90)
  .height(90)
  .margin({ top: 120 })
}

@Extend(Text)
function titleStyle() {
  .fontSize(21)
  .fontColor(Color.White)
  .fontWeight(FontWeight.Bold)
  .margin({ top: 15 })
}

@Styles
function bgStyle() {
  .width('100%')
  .height('100%')
  .backgroundImage($r('app.media.mathmatical'))
  .backgroundImageSize({ width: '100%', height: '100%' })
}

@Extend(Text)
function footerStyle() {
  .fontSize(12)
  .fontColor('#ff7ba416')
  .fontWeight(FontWeight.Bold)
  .margin({ bottom: 30 })
}