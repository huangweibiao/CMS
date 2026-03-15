<template>
  <div class="content-edit-container">
    <Header />
    <div class="content">
      <div class="page-header">
        <h1>{{ isEdit ? '编辑内容' : '创建内容' }}</h1>
        <router-link to="/content" class="btn btn-secondary">返回列表</router-link>
      </div>
      <form @submit.prevent="handleSubmit" class="content-form">
        <div class="form-group">
          <label>标题</label>
          <input
            v-model="form.title"
            type="text"
            placeholder="请输入标题"
            required
          />
        </div>
        <div class="form-group">
          <label>分类</label>
          <input
            v-model="form.category"
            type="text"
            placeholder="请输入分类"
          />
        </div>
        <div class="form-group">
          <label>标签</label>
          <input
            v-model="form.tags"
            type="text"
            placeholder="多个标签用逗号分隔"
          />
        </div>
        <div class="form-group">
          <label>状态</label>
          <select v-model="form.status">
            <option value="draft">草稿</option>
            <option value="published">已发布</option>
          </select>
        </div>
        <div class="form-group">
          <label>内容</label>
          <textarea
            v-model="form.content"
            rows="15"
            placeholder="请输入内容"
            required
          ></textarea>
        </div>
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">保存</button>
          <router-link to="/content" class="btn btn-secondary">取消</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import Header from '../components/Header.vue'
import { getContentById, createContent, updateContent } from '../api/content'
import type { Content } from '../types'

const route = useRoute()
const router = useRouter()

const isEdit = computed(() => !!route.params.id)
const form = ref<Partial<Content>>({
  title: '',
  category: '',
  tags: '',
  status: 'draft',
  content: ''
})

const loadContent = async () => {
  const id = Number(route.params.id)
  if (id) {
    try {
      const response = await getContentById(id)
      if (response.code === 200 && response.data) {
        form.value = response.data
      }
    } catch (error) {
      console.error('Failed to load content:', error)
    }
  }
}

const handleSubmit = async () => {
  try {
    const { user } = useUserStore()
    const data = {
      ...form.value,
      authorId: user.value?.id,
      authorName: user.value?.nickname || user.value?.username
    } as Content

    let response
    if (isEdit.value) {
      data.id = Number(route.params.id)
      response = await updateContent(data)
    } else {
      response = await createContent(data)
    }

    if (response.code === 200) {
      router.push('/content')
    }
  } catch (error) {
    console.error('Failed to save content:', error)
  }
}

onMounted(() => {
  if (isEdit.value) {
    loadContent()
  }
})
</script>

<style scoped>
.content {
  padding: 40px 20px;
  max-width: 900px;
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

.content-form {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  color: #333;
  font-weight: 500;
}

.form-group input,
.form-group select,
.form-group textarea {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  transition: border-color 0.3s;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
  outline: none;
  border-color: #1890ff;
}

.form-actions {
  display: flex;
  gap: 10px;
  margin-top: 30px;
}

.btn {
  padding: 10px 24px;
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
  border: none;
}

.btn-primary:hover {
  background: #40a9ff;
}

.btn-secondary {
  background: #f0f0f0;
  color: #333;
}

.btn-secondary:hover {
  background: #e0e0e0;
}
</style>

<script>
import { useUserStore } from '../stores/user'
</script>
