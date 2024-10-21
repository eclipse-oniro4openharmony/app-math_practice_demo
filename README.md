# Math Practice Demo
An application used to help user practice some math problems.

Proposal topic: Oniro English Word Punch In
1.	Introduction
      Oniro English Word application aimed to provide user a straight forward, easy using English memory tool. Help user to remember English words.

2.	Functionalities
      Main Functions
      •  Practice
-	Provided a page of doing vocabulary practice for users, the user click‘start’to start the practice, and also a time count will start counting at the same time.
-	The user can set the vocabularies number of the practice.
-	Displayed correct answer rate and practice progress.
-	Clicking options shows correct answer if the answer is incorrect.
-	The user can click‘end practice’to finish the practice in advance.

•  Punch In Function
-	When the practice finishes, a summary widget will pop up, we can either start another round or login to punch in.
-	There is another ‘circle’ tab will show all different users punch in record, and users can interact with other users records.
     •  User Center
-	User can logout.
-	User can check their own punch in record and personal information.
-	User can register account and login the application.
3.	Requirements
      3.1 Practice module requirements
-	Common layout container: Column, Row and etc.
-	Common Components: Progress, Button, Image, Text, TextTimmer and etc.
-	Custom Component
-	Custom Window
-	Decorator: @State, @Prop, @Link, @Watch and etc.
     3.2 Basic layout and styles
     Practice Page:
-	Basic layout:



-	Component styles:
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
3.3	Practice Status
There are 3 different status of the practice: Running, Paused, Stopped. We use an enum type to define such states.

For this purpose, we should create a new folder named ‘enums/practiceStatus.ets’ under the ‘ets’ folder.

export enum PracticeStatus{
Running,
Paused,
Stopped
}
Afterwards, we should define such state in our practice page:
@State practiceStatus: PracticeStatus = PracticeStatus.Stopped

Each state should have different version of layout, for example:
Stopped status should be like above image.
Paused status: Left button should be unclickable
Running status: Right button should be labelled as ‘Pause’(Button will be lighter as well)
Button('End')
.controlButtonStyle(
Color.Transparent,
this.practiceStatus === PracticeStatus.Stopped ? Color.Gray : Color.Black,
this.practiceStatus === PracticeStatus.Stopped ? Color.Gray : Color.Black,
)
.enabled(this.practiceStatus !== PracticeStatus.Stopped)
Button(this.practiceStatus === PracticeStatus.Running ? 'Pause' : 'Start')
.controlButtonStyle(
this.practiceStatus === PracticeStatus.Running ? Color.Gray : Color.Black,
Color.White,
this.practiceStatus === PracticeStatus.Running ? Color.Gray : Color.Black,
)
About the onClick event, it is good to add relevant functions as well
3.4	Problem Changing Logic
The changing logic should be implemented with 2 different state variables: Problem array and the array index.
Problem array stores all the problems, and index refers to the index of current problem.
We can change the problem by changing the current index.

For this purpose, we should create a new folder named ‘models/Questions.ets’ under the ‘ets’ folder.

We put the problems data and the Question model here.

-	How to trigger problem changing logic?
     It will be triggered after we change the value of state variable currentIndex.

When we click one of the option, there should be a delay of 0.5s to show the correct answers.
- During the 0.5s, the button should be unclickable.
- A prompt window should pop out when we click the option and didn’t click start button.

Judging answer correct or wrong
There are 3 different status of the options: Default, Correct, Wrong. We use an enum type to define such states.

For this purpose, we should create a new folder named ‘enums/optionStatus.ets’ under the ‘ets’ folder.

We should extract the options button component as define related button status into the component.

o	How to trigger each button’s status when we click the option?



*If we modifying 2 @Prop variables, the update order is the same as the define order.
3.6 Summary Information
Because of the similarity of each summarized information, we can consider to extract each summary information item as a custom component, three parameters are required:
Icon, Name and UI Component.

4.	Development Schedule

 	
