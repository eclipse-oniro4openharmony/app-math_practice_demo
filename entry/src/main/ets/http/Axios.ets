import axios, { AxiosError, InternalAxiosRequestConfig, AxiosResponse } from '@ohos/axios'
import promptAction from '@ohos.promptAction';

//Create axios instance
export const instance = axios.create({
  baseURL: 'xxxxxxxxxxxxxxx',
  timeout: 2000, // 2 second
})

//Add request interceptor
instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  //Get token from AppStorage
  const token: string = AppStorage.Get('token')
  if (token) {
    //If token exists, add it to request header
    config.headers['token'] = token
  }
  return config;
},
  (error: AxiosError) => {
    //If there is an error occur, add it to the request header
    promptAction.showToast({ message: error.message })
    return Promise.reject(error);
  });

//Add response interceptor
instance.interceptors.response.use((response: AxiosResponse) => {
  //If the server returns normal data, no operation
  if (response.data.code === 200) {
    return response
  } else {
    //If the server returns weird data, show it
    promptAction.showToast({ message: response.data.message })
    return Promise.reject(response.data.message)
  }
},
  (error: AxiosError) => {
    //If pop weird data, show it
    promptAction.showToast({ message: error.message })
    return Promise.reject(error);
  })