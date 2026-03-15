import request from '../utils/request'
import type { Content, ApiResponse } from '../types'

export const getContentList = (): Promise<ApiResponse<Content[]>> => {
  return request.get('/content/list')
}

export const getContentById = (id: number): Promise<ApiResponse<Content>> => {
  return request.get(`/content/${id}`)
}

export const createContent = (data: Content): Promise<ApiResponse<Content>> => {
  return request.post('/content/create', data)
}

export const updateContent = (data: Content): Promise<ApiResponse<Content>> => {
  return request.put('/content/update', data)
}

export const deleteContent = (id: number): Promise<ApiResponse<void>> => {
  return request.delete(`/content/${id}`)
}
