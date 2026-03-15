import { createRouter, createWebHashHistory } from 'vue-router'
import { useUserStore } from '../stores/user'

const router = createRouter({
  history: createWebHashHistory(),
  routes: [
    {
      path: '/login',
      name: 'Login',
      component: () => import('../views/Login.vue')
    },
    {
      path: '/',
      name: 'Home',
      component: () => import('../views/Home.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/content',
      name: 'ContentList',
      component: () => import('../views/ContentList.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/content/create',
      name: 'ContentCreate',
      component: () => import('../views/ContentEdit.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/content/:id/edit',
      name: 'ContentEdit',
      component: () => import('../views/ContentEdit.vue'),
      meta: { requiresAuth: true }
    }
  ]
})

router.beforeEach((to, from, next) => {
  const userStore = useUserStore()

  if (to.meta.requiresAuth && !userStore.isAuthenticated) {
    next({ name: 'Login', query: { redirect: to.fullPath } })
  } else if (to.name === 'Login' && userStore.isAuthenticated) {
    next({ name: 'Home' })
  } else {
    next()
  }
})

export default router
