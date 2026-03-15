import request from '../utils/request'
import type { User, ApiResponse } from '../types'

export const getUserInfo = (): Promise<ApiResponse<User>> => {
  return request.get('/user/info')
}
