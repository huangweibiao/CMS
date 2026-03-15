import axios from 'axios'
import type { ApiResponse } from '../types'

const request = axios.create({
  baseURL: '/api',
  timeout: 10000,
  withCredentials: true
})

request.interceptors.response.use(
  response => {
    return response.data
  },
  error => {
    console.error('Request error:', error)
    return Promise.reject(error)
  }
)

export default request
