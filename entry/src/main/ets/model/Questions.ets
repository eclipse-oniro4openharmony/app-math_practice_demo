export interface Question {
  problem: string;
  options: string[];
  answer: string;
}

export const questionData: Question[] = [
  {
    problem: "1+1=?",
    options: ["1", "2", "3", "4"],
    answer: "2",
  },
  {
    problem: "1+2=?",
    options: ["1", "2", "3", "4"],
    answer: "3",
  },
  {
    problem: "1+3=?",
    options: ["1", "2", "3", "4"],
    answer: "4",
  },
  {
    problem: "1+4=?",
    options: ["1", "2", "3", "5"],
    answer: "5",
  },
  {
    problem: "1+5=?",
    options: ["1", "2", "3", "6"],
    answer: "6",
  },
]

export function getRandomQuestions(count: number) {
  let length = questionData.length;
  //stores random indexes
  let indexes: number[] = [];
  while (indexes.length < count) {
    //get random index from 0 to length
    let index = Math.floor(Math.random() * length);
    if(!indexes.includes(index)){
      indexes.push(index)
    }
  }
  //use map to return index corresponding problems
  return indexes.map(index=>questionData[index])
}