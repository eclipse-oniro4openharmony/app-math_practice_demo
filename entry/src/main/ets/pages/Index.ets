import { PracticePage } from './PracticePage';
import { PunchPage } from './PunchPage';
import { MyPage } from './MyPage'

@Entry
@Component
struct Index {
  @State currentTabIndex: number = 0;

  build() {
    Tabs() {
      TabContent() {
        PracticePage()
      }.tabBar(this.barBuilder(0, $r('app.string.Practice'), $r('app.media.practice'), $r('app.media.practice_selected')))

      TabContent() {
        PunchPage()
      }.tabBar(this.barBuilder(1, $r('app.string.Moments'), $r('app.media.moment'), $r('app.media.moment_selected')))

      TabContent() {
        MyPage()
      }.tabBar(this.barBuilder(2, $r('app.string.My'), $r('app.media.my'), $r('app.media.my_selected')))
    }
    .barPosition(BarPosition.End)
    .onChange((index) => {
      this.currentTabIndex = index;
    })
  }

  @Builder
  barBuilder(index: number, title: string|Resource, icon: Resource, iconSelected: Resource) {
    Column() {
      Image(this.currentTabIndex === index ? iconSelected : icon)
        .width(25)
        .height(25)
      Text(title)
        .tabTitleStyle(this.currentTabIndex === index ? Color.Black : '#959595')
    }
  }
}

@Extend(Text)
function tabTitleStyle(color: ResourceColor) {
  .fontSize(10)
  .fontWeight(FontWeight.Medium)
  .margin({ bottom: 2 })
  .fontColor(color)
}