# Math Practice Demo

    An application used to help user practice some math problems.

## Introduction

      Math practice application aimed to provide user a straight forward, easy using Math problem practice tool. 
      
      Help user to enhand their math grades.

## Functionalities

    Main Functions
    
    •  Practice
        -	Provided a page of doing math practice for users, the user click‘start’to start the practice, and also a time count will start counting at the same time.
        -	The user can set the problem number of the practice.
        -	Displayed correct answer rate and practice progress.
        -	Clicking options shows correct answer if the answer is incorrect.
        -	The user can click ‘End’ button to finish the practice in advance.

    •  Punch In Function
        -	When the practice finishes, a summary widget will pop up, we can either start another round or login to punch in.
        -	There is another ‘Moment’ tab will show all different users punch in record, and users can interact with other users records.
   
    •  User Center
        -	User can logout.
        -	User can check their own punch in record and personal information.
        -	User can register account and login the application.

## Requirements

        -	Common layout container: Column, Row and etc.
        -	Common Components: Progress, Button, Image, Text, TextTimmer and etc.
        -	Custom Component
        -	Custom Window
        -	Decorator: @State, @Prop, @Link, @Watch and etc.

## Implementation

### 1. Practice Status

    There are 3 different status of the practice: Running, Paused, Stopped. We use an enum type to define such states.

    For this purpose, we should create a new folder named ‘enums/practiceStatus.ets’ under the ‘ets’ folder.

```typescript
    export enum PracticeStatus{
Running,
Paused,
Stopped
}
```

    Afterwards, we should define such state in our practice page:

```typescript
@State
practiceStatus: PracticeStatus = PracticeStatus.Stopped
```    

    Each state should have different version of layout:

    Paused status: Both button should be clickable
    Running status: ‘Start’ button should be replaced by ‘Pause’ button,‘End’ button should be clickable
    Stopped status: ‘Start’ button should be clickable, ‘End’ button should be unclickable

### 2. Problem Changing Logic

    The changing logic should be implemented with 2 different state variables: Problem array and the array index.
    Problem array stores all the problems, and index refers to the index of current problem.
    We can change the problem by changing the current index.

    For this purpose, we should create a new folder named ‘models/Questions.ets’ under the ‘ets’ folder.

    We put the problems data and the Question model here.

#### How to trigger problem changing logic?

    It will be triggered after we change the value of state variable currentIndex.

    When we click one of the option, there should be a delay of 0.5s to show the correct answers.
    
    - During the 0.5s, the button should be unclickable.
    - A prompt window should pop out when we click the option and didn’t click start button.

### Judging answer correct or wrong
    There are 3 different status of the options: Default, Correct, Wrong. We use an enum type to define such states.
    
    For this purpose, we should create a new folder named ‘enums/optionStatus.ets’ under the ‘ets’ folder.
    We should extract the options button component as define related button status into the component.
 
#### How to trigger each button’s status when we click the option?
    In normal case, each time of changing problem, ForEach rendered component will refactor again, so we only need to consider how to change the option status from Default to Correct or Wrong.
    
    Attention:
    If there are similar options for recent 2 problems, ForEach will try to reuse the previous UI component. Therefore, some of the OptionButton component might not be refactored. At this moment we also have to consider how to change Correct/Wrong status back to Default status.
    
    Solution:
     Set the keyGenerator of the ForEach into:
     option=>this.questions[this.currentIndex].word+’-’+option
     It ensures each problem will rerender to UI component of the options.
     We can set a same attribute between the PracticePage component and OptionButtonComponent(use @Prop decorator), and define a @Watch event, each time of trigger, each button will change to corresponding color.

### Summary Information
    Because of the similarity of each summarized information, we can consider to extract each summary information item as a
    custom component, three parameters are required:
    Icon, Name and UI Component.


 	
