import { DEFAULT } from '@ohos/hypium';

export interface Question {
  problem: string;
  options: string[];
  answer: string;
}

// export const questionData: Question[] = [
//   {
//     problem: "1+1=?",
//     options: ["1", "2", "3", "4"],
//     answer: "2",
//   },
//   {
//     problem: "1+2=?",
//     options: ["1", "2", "3", "4"],
//     answer: "3",
//   },
//   {
//     problem: "1+3=?",
//     options: ["1", "2", "3", "4"],
//     answer: "4",
//   },
//   {
//     problem: "1+4=?",
//     options: ["1", "2", "3", "5"],
//     answer: "5",
//   },
//   {
//     problem: "1+5=?",
//     options: ["1", "2", "3", "6"],
//     answer: "6",
//   },
// ]

// export function getRandomQuestions(count: number) {
//   let length = questionData.length;
//   //stores random indexes
//   let indexes: number[] = [];
//   while (indexes.length < count) {
//     //get random index from 0 to length
//     let index = Math.floor(Math.random() * length);
//     if(!indexes.includes(index)){
//       indexes.push(index)
//     }
//   }
//   //use map to return index corresponding problems
//   return indexes.map(index=>questionData[index])
// }

function generateRandomQuestion(): Question {
  const num1 = Math.floor(Math.random() * 10); // 随机生成 0 到 9 的数字
  const num2 = Math.floor(Math.random() * 10);
  const operators: string[] = ['+', '-', 'x', '÷']
  // get random index of operator array
  let index = Math.floor(Math.random() * operators.length)
  const randomOperator: string = operators[index]
  let answer: number | string = 0
  switch (randomOperator) {
    case '+':
      answer = num1 + num2
      break
    case '-':
      answer = num1 - num2
      break
    case 'x':
      answer = num1 * num2
      break
    case '÷':
      answer = num2 === 0 ? 'Not exist' : (num1 / num2).toFixed(2)
      break
    default:
      break
  }

  // Create option array and make sure the answer is inside
  const options = new Set<number | string>();
  options.add(answer); // Add the answer option

  // Generate other random options
  while (options.size < 4) {
    const randomOption = Math.floor(Math.random() * 100); // 生成 0 到 100 的随机数字
    options.add(randomOption);
  }

  // Convert options into array and randomize it
  const shuffledOptions = Array.from(options).sort(() => 0.5 - Math.random());

  // Return generated problem
  return {
    problem: `${num1} ${randomOperator} ${num2} = ?`,
    options: shuffledOptions.map(String), // Convert into string
    answer: String(answer),
  };
}

// Generate given number of problems
export function generateRandomQuestions(count: number): Question[] {
  const questions: Question[] = [];
  for (let i = 0; i < count; i++) {
    questions.push(generateRandomQuestion());
  }
  return questions;
}

