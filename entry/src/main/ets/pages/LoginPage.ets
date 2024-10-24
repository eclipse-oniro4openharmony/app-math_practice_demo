import router from '@ohos.router';

@Entry
@Component
struct LoginPage {
  build() {
    Column() {
      Image($r('app.media.back'))
        .backStyle()
        .alignSelf(ItemAlign.Start)
        .onClick(() => {
          router.back()
        })
      Blank()
      Column() {
        Text('Welcome Login')
          .titleStyle()

        Row() {
          Image($r('app.media.phone'))
            .iconStyle()
          TextInput({ placeholder: 'Phone number' })
            .inputStyle()
        }
        .margin({ top: 30 })

        Divider()
          .color(Color.Black)
          .strokeWidth(1)
        Row() {
          Image($r('app.media.security'))
            .iconStyle()
          TextInput({ placeholder: 'Code' })
            .inputStyle()

          Button('Get Code')
            .buttonlStyle(
              Color.Black,
              Color.White,
            )
            .onClick(() => {
              // to do: Get code
            })
        }.margin({ top: 30 })

        Divider()
          .color(Color.Black)
          .margin({ right: 120 })
          .strokeWidth(1)

        Button('Login')
          .buttonlStyle(
            Color.Black,
            Color.White
          )
          .width('100%')
          .margin({ top: 50 })
          .onClick(() => {
            //to do: login
          })


      }
      .loginContainerStyle()
      .alignItems(HorizontalAlign.Start)
      .formBgStyle()

      Column(){
        Row({space: 10}){
          Image($r('app.media.math_icon'))
            .iconStyle()
          Text('Practice Math')
            .fontWeight(700)
        }
        .margin({top: 150})
        Text('Development by Chen')
          .margin({top: 10})
          .fontColor('#611a5694')
      }
    }
    .loginBgStyle()
  }
}

@Extend(Image)
function backStyle() {
  .width(25)
  .height(25)
}

@Extend(Image)
function iconStyle() {
  .width(25)
  .height(25)
}

@Extend(TextInput)
function inputStyle() {
  .height(40)
  .backgroundColor(Color.Transparent)
  .fontSize(14)
  .layoutWeight(1)
}

@Extend(Button)
function buttonlStyle(
  btColor: ResourceColor,
  fontColor: ResourceColor,
) {
  .fontColor(fontColor)
  .backgroundColor(btColor)
  .height('5%')
  .type(ButtonType.Normal)
  .fontSize(14)
  .borderWidth(1)
  .borderRadius(5)
  .fontWeight(FontWeight.Medium)
}

@Extend(Column)
function loginContainerStyle() {
  .width('70%')
}

@Styles
function formBgStyle() {
  .padding(30)
  .borderRadius(20)
  .backgroundColor(Color.White)
  .width('100%')
}

@Styles
function loginBgStyle() {
  .width('100%')
  .height('100%')
  .backgroundColor(Color.Orange)
  .padding({
    top: 30,
    bottom: 30,
    left: 30,
    right: 30
  })
}

@Extend(Text)
function titleStyle() {
  .fontSize(22)
  .alignSelf(ItemAlign.Center)
  .fontWeight(700)
}

@Extend(Column)
function footerStyle() {
  .width('50%')
}