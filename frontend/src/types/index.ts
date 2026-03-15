export interface User {
  id: number
  username: string
  email: string
  nickname: string
  avatar: string
  oauth2Id: string
  oauth2Provider: string
}

export interface Content {
  id: number
  title: string
  content: string
  category: string
  tags: string
  status: string
  authorId: number
  authorName: string
  viewCount: number
  likeCount: number
  createTime: string
  updateTime: string
}

export interface ApiResponse<T> {
  code: number
  message: string
  data: T
}
