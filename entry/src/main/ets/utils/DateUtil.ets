export function convertMillisecondsToTime(timeUsed: number):string{
  const hours = Math.floor(timeUsed/3600000);
  const minutes = Math.floor((timeUsed%3600000)/60000);
  const seconds = Math.floor((timeUsed%60000)/1000);

  if(hours>0){
    return `${hours}h ${minutes}m ${seconds}s`
  }
  else if(minutes>0){
    return `${minutes}m ${seconds}s`
  }
  else{
    return `${seconds}s`
  }
}