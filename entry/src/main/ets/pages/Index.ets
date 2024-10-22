import { PracticePage } from './PracticePage';

@Entry
@Component
struct Index {
  @State currentTabIndex: number = 0;

  build() {
    Tabs() {
      TabContent() {
        PracticePage()
      }.tabBar(this.barBuilder(0,'Practice',$r('app.media.practice'),$r('app.media.practice_selected')))

      TabContent() {
        Text('Moments')
      }.tabBar(this.barBuilder(1,'Moments',$r('app.media.moment'),$r('app.media.moment_selected')))

      TabContent() {
        Text('My')
      }.tabBar(this.barBuilder(2,'My',$r('app.media.my'),$r('app.media.my_selected')))
    }
    .barPosition(BarPosition.End)
    .onChange((index) => {
      this.currentTabIndex = index;
    })
  }

  @Builder
  barBuilder(index: number, title: string, icon: Resource, iconSelected: Resource) {
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