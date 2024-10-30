export interface PostInfo {
  id: number;
  postText: string;
  correctCount: number;
  answeredCount: number;
  timeUsed: number;
  createdTime: string;
  likeCount: number;
  nickname: string;
  avatarUrl: string | Resource;
  isLike: boolean;
}

// export const postInfoData: PostInfo[] = [
//   {
//     id: 1,
//     postText: 'I\'m doing well this time',
//     correctCount: 1,
//     answeredCount: 2,
//     timeUsed: 4232,
//     createdTime: '2024-3-13 14:32:32',
//     likeCount: 1,
//     nickname: 'Alfred',
//     avatarUrl: $r('app.media.accuracy'),
//     isLike: false
//   },
//   {
//     id: 2,
//     postText: 'I\'m doing well this time 2',
//     correctCount: 1,
//     answeredCount: 2,
//     timeUsed: 4232,
//     createdTime: '2024-3-13 14:32:32',
//     likeCount: 1,
//     nickname: 'Alfred',
//     avatarUrl: $r('app.media.accuracy'),
//     isLike: false
//   },
//   {
//     id: 3,
//     postText: 'I\'m doing well this time 3',
//     correctCount: 1,
//     answeredCount: 2,
//     timeUsed: 4232,
//     createdTime: '2024-3-13 14:32:32',
//     likeCount: 1,
//     nickname: 'Alfred',
//     avatarUrl: $r('app.media.accuracy'),
//     isLike: false
//   },
//   {
//     id: 4,
//     postText: 'I\'m doing well this time 4',
//     correctCount: 1,
//     answeredCount: 2,
//     timeUsed: 4232,
//     createdTime: '2024-3-13 14:32:32',
//     likeCount: 1,
//     nickname: 'Alfred',
//     avatarUrl: $r('app.media.accuracy'),
//     isLike: false
//   },
//   {
//     id: 5,
//     postText: 'I\'m doing well this time 5',
//     correctCount: 1,
//     answeredCount: 2,
//     timeUsed: 4232,
//     createdTime: '2024-3-13 14:32:32',
//     likeCount: 1,
//     nickname: 'Alfred',
//     avatarUrl: $r('app.media.accuracy'),
//     isLike: false
//   },
//   {
//     id: 6,
//     postText: 'I\'m doing well this time 6',
//     correctCount: 1,
//     answeredCount: 2,
//     timeUsed: 4232,
//     createdTime: '2024-3-13 14:32:32',
//     likeCount: 1,
//     nickname: 'Alfred',
//     avatarUrl: $r('app.media.accuracy'),
//     isLike: false
//   },
//   {
//     id: 7,
//     postText: 'I\'m doing well this time 7',
//     correctCount: 1,
//     answeredCount: 2,
//     timeUsed: 4232,
//     createdTime: '2024-3-13 14:32:32',
//     likeCount: 1,
//     nickname: 'Alfred',
//     avatarUrl: $r('app.media.accuracy'),
//     isLike: false
//   },
// ]

function getTime(): string {
  let date: Date = new Date();
  return date.toLocaleString()
}

export function generatePunchRecord(
  id: number,
  correctCount: number,
  answeredCount: number,
  timeUsed: number
): PostInfo {

  return {
    id: id,
    postText: 'This is the sample user comment for this exercise',
    correctCount: correctCount,
    answeredCount: answeredCount,
    timeUsed: timeUsed,
    createdTime: getTime(),
    likeCount: 1,
    avatarUrl: $r('app.media.accuracy'),
    isLike: false,
    nickname: 'Alfred',
  }
}
