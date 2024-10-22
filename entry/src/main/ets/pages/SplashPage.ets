@Entry
@Component
struct SplashPage {

  build() {
    Column(){
        Image($r('app.media.math_icon'))
          .logoStyle()
    }
  }
}

@Extend(Image) function logoStyle(){
  .width(90)
  .height(90)
  .margin({top: 120})
}