import { defineStore } from 'pinia'
import { ref } from 'vue'
import type { User } from '../types'
import { getUserInfo } from '../api/user'

export const useUserStore = defineStore('user', () => {
  const user = ref<User | null>(null)
  const isAuthenticated = ref(false)

  const checkAuth = async () => {
    try {
      const response = await getUserInfo()
      if (response.code === 200 && response.data) {
        user.value = response.data
        isAuthenticated.value = true
      }
    } catch (error) {
      console.error('Auth check failed:', error)
      isAuthenticated.value = false
    }
  }

  const login = (userData: User) => {
    user.value = userData
    isAuthenticated.value = true
  }

  const logout = () => {
    user.value = null
    isAuthenticated.value = false
    window.location.href = '/api/logout'
  }

  return {
    user,
    isAuthenticated,
    checkAuth,
    login,
    logout
  }
})
