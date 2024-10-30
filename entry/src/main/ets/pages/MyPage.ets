import router from '@ohos.router';
import { UserInfo } from '../model/userInfo'

@Entry
@Component
export struct MyPage {
  @State userInfo: UserInfo = {
    nickname: 'Alfred',
    avatarUrl: $r('app.media.mathmatical')
  };

  build() {
    Column() {

      Column({ space: 10 }) {
        Image(this.userInfo.avatarUrl)
          .width(100)
          .height(100)
          .borderRadius(50)
        Text(this.userInfo.nickname)
      }
      .backgroundImage(this.userInfo.avatarUrl)
      .backgroundImageSize({ width: '100%', height: '100%' })
      .backgroundBlurStyle(BlurStyle.BACKGROUND_THIN)
      .userBgStyle()

      Column() {
        OptionBuilder(
          $r('app.media.history'),
          $r('app.string.Punch_record'),
          $r('app.media.enter'),
        )

        OptionBuilder(
          $r('app.media.update'),
          $r('app.string.Check_updates'),
          $r('app.media.enter')
        )

        OptionBuilder(
          $r('app.media.about'),
          $r('app.string.About'),
          $r('app.media.enter')
        )
      }

      Blank()
      Button($r('app.string.Login'))
        .margin({ bottom: 30 })
        .width('40%')
        .backgroundColor(Color.Gray)
        .onClick(() => {
          router.pushUrl({ url: 'pages/LoginPage' })
        })
    }
    .width('100%')
    .height('100%')
  }
}

@Extend(Column)
function userBgStyle() {
  .height('50%')
  .width('100%')
  .backgroundColor(Color.Gray)
  .justifyContent(FlexAlign.Center)
}

@Builder
function OptionBuilder(imageUrl_1: string | Resource, text: string|Resource, imageUrl_2: string | Resource) {
  Row({ space: 20 }) {
    Image(imageUrl_1)
      .width(20)
      .height(20)
    Text(text)
    Blank()
    Image(imageUrl_2)
      .width(20)
      .height(20)

  }
  .width('100%')
  .height('8%')
  .padding(10)
  .backgroundColor(Color.Transparent)

  Divider()
    .color('#16232323')
    .strokeWidth(2)
    .width('95%')
}