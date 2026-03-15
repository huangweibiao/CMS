<template>
  <div class="home-container">
    <Header />
    <div class="content">
      <div class="welcome-section">
        <h1>欢迎回来，{{ userStore.user?.nickname || userStore.user?.username }}！</h1>
        <p>这是您的内容管理系统</p>
      </div>
      <div class="quick-actions">
        <router-link to="/content" class="action-card">
          <h2>内容管理</h2>
          <p>查看和管理所有内容</p>
        </router-link>
        <router-link to="/content/create" class="action-card">
          <h2>创建内容</h2>
          <p>开始创建新的内容</p>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import Header from '../components/Header.vue'
import { useUserStore } from '../stores/user'

const userStore = useUserStore()
</script>

<style scoped>
.home-container {
  min-height: 100vh;
  background: #f5f5f5;
}

.content {
  padding: 40px 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.welcome-section {
  text-align: center;
  margin-bottom: 40px;
}

.welcome-section h1 {
  font-size: 32px;
  color: #333;
  margin-bottom: 10px;
}

.welcome-section p {
  color: #666;
  font-size: 16px;
}

.quick-actions {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
}

.action-card {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  text-decoration: none;
  color: #333;
  transition: all 0.3s;
}

.action-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
}

.action-card h2 {
  font-size: 20px;
  margin-bottom: 10px;
  color: #1890ff;
}

.action-card p {
  color: #666;
}
</style>
