<template>
  <header class="header">
    <div class="header-content">
      <div class="logo">
        <router-link to="/">CMS</router-link>
      </div>
      <nav class="nav">
        <router-link to="/" class="nav-link">首页</router-link>
        <router-link to="/content" class="nav-link">内容管理</router-link>
      </nav>
      <div class="user-actions">
        <span v-if="userStore.user" class="user-name">
          {{ userStore.user.nickname || userStore.user.username }}
        </span>
        <button v-if="userStore.isAuthenticated" @click="handleLogout" class="logout-btn">
          退出
        </button>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
import { useUserStore } from '../stores/user'
import { useRouter } from 'vue-router'

const userStore = useUserStore()
const router = useRouter()

const handleLogout = () => {
  userStore.logout()
  router.push('/login')
}
</script>

<style scoped>
.header {
  background: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  height: 64px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.logo a {
  font-size: 24px;
  font-weight: bold;
  color: #1890ff;
  text-decoration: none;
}

.nav {
  display: flex;
  gap: 30px;
}

.nav-link {
  color: #333;
  text-decoration: none;
  font-size: 14px;
  transition: color 0.3s;
}

.nav-link:hover,
.nav-link.router-link-active {
  color: #1890ff;
}

.user-actions {
  display: flex;
  align-items: center;
  gap: 20px;
}

.user-name {
  color: #666;
  font-size: 14px;
}

.logout-btn {
  background: none;
  border: 1px solid #d9d9d9;
  padding: 6px 16px;
  border-radius: 4px;
  font-size: 14px;
  color: #666;
  transition: all 0.3s;
}

.logout-btn:hover {
  border-color: #1890ff;
  color: #1890ff;
}
</style>
