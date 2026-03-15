<template>
  <div class="content-list-container">
    <Header />
    <div class="content">
      <div class="page-header">
        <h1>内容列表</h1>
        <router-link to="/content/create" class="btn btn-primary">创建内容</router-link>
      </div>
      <div class="content-grid" v-if="contents.length > 0">
        <div v-for="item in contents" :key="item.id" class="content-card">
          <h3>{{ item.title }}</h3>
          <p class="meta">
            <span>作者: {{ item.authorName }}</span>
            <span>分类: {{ item.category || '未分类' }}</span>
            <span>状态: {{ item.status }}</span>
          </p>
          <p class="summary">{{ item.content.substring(0, 100) }}...</p>
          <div class="actions">
            <router-link :to="`/content/${item.id}/edit`" class="btn btn-small">编辑</router-link>
            <button @click="handleDelete(item.id)" class="btn btn-small btn-danger">删除</button>
          </div>
        </div>
      </div>
      <div v-else class="empty">
        <p>暂无内容，点击上方按钮创建新内容</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import Header from '../components/Header.vue'
import { getContentList, deleteContent } from '../api/content'
import type { Content } from '../types'

const contents = ref<Content[]>([])

const loadContents = async () => {
  try {
    const response = await getContentList()
    if (response.code === 200) {
      contents.value = response.data || []
    }
  } catch (error) {
    console.error('Failed to load contents:', error)
  }
}

const handleDelete = async (id: number) => {
  if (!confirm('确定要删除此内容吗？')) return
  try {
    await deleteContent(id)
    loadContents()
  } catch (error) {
    console.error('Failed to delete content:', error)
  }
}

onMounted(() => {
  loadContents()
})
</script>

<style scoped>
.content {
  padding: 40px 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

.page-header h1 {
  font-size: 28px;
  color: #333;
}

.content-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 20px;
}

.content-card {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.content-card h3 {
  font-size: 18px;
  color: #333;
  margin-bottom: 10px;
}

.meta {
  display: flex;
  gap: 15px;
  font-size: 12px;
  color: #999;
  margin-bottom: 10px;
}

.summary {
  color: #666;
  font-size: 14px;
  line-height: 1.6;
  margin-bottom: 15px;
}

.actions {
  display: flex;
  gap: 10px;
}

.btn {
  padding: 8px 16px;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.3s;
  text-decoration: none;
  display: inline-block;
}

.btn-primary {
  background: #1890ff;
  color: white;
}

.btn-primary:hover {
  background: #40a9ff;
}

.btn-small {
  padding: 6px 12px;
  font-size: 12px;
  background: #f0f0f0;
  color: #333;
}

.btn-small:hover {
  background: #e0e0e0;
}

.btn-danger {
  background: #ff4d4f;
  color: white;
}

.btn-danger:hover {
  background: #ff7875;
}

.empty {
  text-align: center;
  padding: 60px;
  color: #999;
}
</style>
