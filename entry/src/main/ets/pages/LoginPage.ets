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
      Column() {
        Text('Welcome Login')

        Row() {
          Image($r('app.media.phone'))
            .iconStyle()
          TextInput({ placeholder: 'Phone number' })
            .inputStyle()
        }
        .margin({ top: 30 })

        Divider()
          .color(Color.Black)
        Row({ space: 10 }) {
          Row() {
            Image($r('app.media.security'))
              .iconStyle()
            TextInput()
              .inputStyle()
          }

          Button('Get Code')
            .buttonlStyle(
              Color.Black,
              Color.White,
            )
            .onClick(() => {
              // to do: Get code
            })
        }.margin({ top: 20 })

        Divider()
          .color(Color.Black)

        Button('Login')
          .buttonlStyle(
            Color.Black,
            Color.White
          )
          .width('100%')
          .margin({ top: 50 })
          .onClick(()=>{
            //to do: login
          })


      }
      .loginContainerStyle()
      .alignItems(HorizontalAlign.Start)
    }
  }
}

@Extend(Image)
function backStyle() {
  .width(25)
  .height(25)
  .margin({ top: 20, left: 20 })
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
function loginContainerStyle(){
  .width('70%')
}