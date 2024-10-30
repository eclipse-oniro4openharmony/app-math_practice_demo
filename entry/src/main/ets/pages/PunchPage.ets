import { PostInfo, postInfoData } from '../model/PostInfo';
import router from '@ohos.router';
import { SummaryItem } from './PracticePage'
import { convertMillisecondsToTime } from '../utils/DateUtil';

@Entry
@Component
export struct PunchPage {
  @State postInfoList: PostInfo[] = postInfoData;
  @State isLoading: boolean = false
  scroller: Scroller = new Scroller()

  aboutToAppear(): void {
    this.isLoading = true
  }

  build() {
    Column() {
      Text($r('app.string.Punch_community'))
        .titleStyle()
      Divider()
        .dividerStyle()


      Column() {
        //Tested already
        //this.unloginBuilder()
        // if (this.isLoading) {
        //   this.loadBuilder()
        // }
        // else {
        //   this.listBuilder()
        // }
        this.listBuilder()

      }
    }
    .bgStyle()
  }

  @Builder
  loadBuilder() {
    Column() {
      Image($r('app.media.loading'))
        .width(30)
        .height(30)
      Text($r('app.string.Loading'))
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  unloginBuilder() {
    Column({ space: 30 }) {

      Text($r('app.string.Login_check_data'))
        .fontSize(15)
        .fontColor('#561a1111')

      Button($r('app.string.Go_login'))
        .height(34)
        .width(100)
        .backgroundColor('#ff0aa79a')
        .onClick(() => {
          router.pushUrl({ url: 'pages/LoginPage' })
        })
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  listBuilder() {
    Stack() {
      List({ scroller: this.scroller }) {
        ForEach(this.postInfoList, (post: PostInfo) => {
          ListItem() {
            PostItem({ post })
          }
        })
      }
      .zIndex(0)

      Column({ space: 20 }) {
        Button({ type: ButtonType.Circle }) {
          Image($r('app.media.top'))
            .height(14)
            .width(14)
        }
        .fontSize(5)
        .zIndex(1)
        .width(40)
        .height(40)
        .opacity(0.5)
        .backgroundColor(Color.Black)
        .onClick(() => {
          this.scroller.scrollEdge(Edge.Top)
        })

        Button({ type: ButtonType.Circle }) {
          Image($r('app.media.refresh'))
            .height(14)
            .width(14)
        }
        .fontSize(5)
        .zIndex(1)
        .width(40)
        .height(40)
        .opacity(0.5)
        .backgroundColor(Color.Black)
        .onClick(() => {
          // todo: refresh
          if (this.isLoading === true) {
            this.postInfoList = [];
            this.postInfoList = postInfoData;
          }
        })
      }
      .offset({
        x: -20,
        y: -100
      })
    }
    .width('100%')
    .layoutWeight(1)
    .alignContent(Alignment.BottomEnd)
  }
}

@Extend(Text)
function titleStyle() {
  .fontWeight(FontWeight.Bold)
  .alignSelf(ItemAlign.Center)
  .fontSize(18)
  .padding(10)
  .margin({ top: 25 })
}

@Extend(Column)
function bgStyle() {
  .width('100%')
  .height('100%')
}

@Extend(Divider)
function dividerStyle() {
  .color(Color.Black)
  .strokeWidth(1)
  .opacity(0.3)
  .margin({ left: '10%', right: '10%', bottom: '1%' })
}

@Component
struct PostItem {
  post!: PostInfo;

  build() {
    Column({ space: 10 }) {
      Row({ space: 10 }) {
        Image(this.post.avatarUrl)
          .width(40)
          .height(40)
          .borderRadius(20)
        Text(this.post.nickname)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(this.post.createdTime)
          .fontColor('#6b1c1a1a')
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: 10, right: 10, top: 10 })

      Text(this.post.postText)
        .width('100%')
        .fontSize(18)
        .padding({ left: 15 })
      Row() {
        Column() {
          SummaryItem({
            icon: $r('app.media.timer'),
            name: $r('app.string.Time'),
            fontColor: Color.Black,
          }) {
            Text(convertMillisecondsToTime(this.post.timeUsed))
          }

          SummaryItem({
            icon: $r('app.media.accuracy'),
            name: $r('app.string.Accuracy'),
            fontColor: Color.Black,
          }) {
            Text(this.post.answeredCount === 0 ? '0%' : (this.post.correctCount / this.post.answeredCount * 100).toFixed() + '%')
          }

          SummaryItem({
            icon: $r('app.media.number'),
            name: $r('app.string.Number'),
            fontColor: Color.Black,
          }) {
            Text(`${this.post.answeredCount}`)
          }
        }
        .padding(10)
        .borderRadius(20)
        .backgroundColor('#8d0e666d')
        .layoutWeight(1)
        .margin({ left: 10, bottom: 10 })

        Column() {
          Text(this.post.likeCount.toString())
            .fontWeight(FontWeight.Bolder)
            .fontSize(12)

          Image(this.post.isLike === true ? $r('app.media.liked') : $r('app.media.like'))
            .width(26)
            .height(26)
            .onClick(() => {
              // todo: like and unlike function
              // this.post.isLike === true ? this.post.isLike = false : this.post.isLike = true;
            })
            .width(40)
        }
        .width('20%')
        .padding(15)
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .cardInfoStyle()
  }
}

// todo: card postion needs to be adjusted
@Extend(Column)
function cardInfoStyle() {
  .width('95%')
  .backgroundColor('#81183283')
  .borderRadius(20)
  .borderColor('#590c0303')
  .borderWidth(2)
  .margin({ left: 10, bottom: 5 })
  .shadow({
    radius: 4,
    color: `rgba(0,0,0,0.3)`,
    offsetY: 10,
    offsetX: -10,
  })
}