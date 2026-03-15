<template>
  <div class="login-container">
    <div class="login-box">
      <h1>CMS 登录</h1>
      <p class="subtitle">内容管理系统</p>
      <a href="/api/oauth2/authorization/oauth2" class="login-btn">
        使用 OAuth2 登录
      </a>
    </div>
  </div>
</template>

<script setup lang="ts">
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.login-box {
  background: white;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
  text-align: center;
  min-width: 400px;
}

.login-box h1 {
  margin-bottom: 10px;
  color: #333;
}

.subtitle {
  color: #666;
  margin-bottom: 30px;
}

.login-btn {
  display: inline-block;
  background: #1890ff;
  color: white;
  padding: 12px 32px;
  border-radius: 6px;
  font-size: 16px;
  transition: all 0.3s;
}

.login-btn:hover {
  background: #40a9ff;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(24, 144, 255, 0.3);
}
</style>
