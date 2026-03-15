# CMS 内容管理系统

基于 Spring Boot 3.5.11 + MySQL 8 + Vue 3 + TypeScript 的单应用内容管理系统，支持 OAuth2 单点登录。

**前后端不分离架构**：Vue前端打包后集成到Spring Boot中，由单一服务器提供服务。

## 技术栈

### 后端
- Spring Boot 3.5.11
- Spring Security + OAuth2
- MyBatis 3.0.3
- MySQL 8.0
- Lombok

### 前端
- Vue 3.4
- TypeScript 5.3
- Vite 5.0
- Vue Router 4.2 (Hash模式)
- Pinia 2.1
- Axios 1.6

## 架构说明

本项目采用**前后端不分离的单体架构**：

1. **开发阶段**：前端和后端独立开发，前端通过代理访问后端API
2. **打包部署**：Vue前端打包后的静态文件集成到Spring Boot的static目录
3. **运行阶段**：Spring Boot统一提供静态资源和API服务，单端口部署

### 优势
- ✅ 简化部署：只需部署一个WAR/JAR包
- ✅ 统一域名：前后端共享同一域名，无跨域问题
- ✅ 减少配置：无需配置反向代理和CORS
- ✅ 适合中小型项目：开发和运维成本较低

## 项目结构

```
cms/
├── backend/                 # 后端项目（包含打包后的前端静态文件）
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/cms/
│   │   │   │   ├── config/     # 配置类（安全、Web、OAuth2等）
│   │   │   │   ├── controller/ # 控制器
│   │   │   │   ├── service/    # 服务层
│   │   │   │   ├── repository/ # 数据访问层
│   │   │   │   ├── entity/     # 实体类
│   │   │   │   ├── dto/        # 数据传输对象
│   │   │   │   └── common/     # 公共类
│   │   │   └── resources/
│   │   │       ├── mapper/     # MyBatis mapper XML
│   │   │       ├── static/     # 前端打包后的静态文件（运行时生成）
│   │   │       ├── application.yml
│   │   │       └── schema.sql
│   └── pom.xml
│
└── frontend/                # 前端项目
    ├── src/
    │   ├── api/             # API 接口
    │   ├── assets/          # 静态资源
    │   ├── components/      # 组件
    │   ├── router/          # 路由配置（Hash模式）
    │   ├── stores/          # Pinia 状态管理
    │   ├── types/           # TypeScript 类型定义
    │   ├── utils/           # 工具函数
    │   ├── views/           # 页面组件
    │   ├── App.vue
    │   └── main.ts
    ├── index.html
    ├── package.json
    └── vite.config.ts       # 配置输出到backend的static目录
```

## 快速开始

### 1. 数据库初始化

执行后端数据库脚本：

```bash
mysql -u root -p < backend/src/main/resources/schema.sql
```

或者手动在 MySQL 中执行：

```sql
CREATE DATABASE cms DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE cms;

-- 用户表
CREATE TABLE user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100),
    nickname VARCHAR(50),
    avatar VARCHAR(255),
    oauth2_id VARCHAR(100),
    oauth2_provider VARCHAR(50),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted TINYINT DEFAULT 0,
    create_by VARCHAR(50) DEFAULT 'system',
    update_by VARCHAR(50) DEFAULT 'system'
);

-- 内容表
CREATE TABLE content (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    category VARCHAR(50),
    tags VARCHAR(200),
    status VARCHAR(20) DEFAULT 'draft',
    author_id BIGINT,
    author_name VARCHAR(50),
    view_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted TINYINT DEFAULT 0,
    create_by VARCHAR(50) DEFAULT 'system',
    update_by VARCHAR(50) DEFAULT 'system'
);
```

### 2. 配置 OAuth2

编辑 `backend/src/main/resources/application.yml`，配置你的 OAuth2 服务端信息：

```yaml
spring:
  security:
    oauth2:
      client:
        registration:
          oauth2:
            client-id: your-client-id        # 你的 OAuth2 客户端 ID
            client-secret: your-client-secret # 你的 OAuth2 客户端密钥
            redirect-uri: http://localhost:8080/login/oauth2/code/oauth2
            scope: openid,profile,email
        provider:
          oauth2:
            authorization-uri: http://your-oauth2-server/oauth2/authorize
            token-uri: http://your-oauth2-server/oauth2/token
            user-info-uri: http://your-oauth2-server/userinfo
```

### 3. 开发模式

#### 3.1 启动后端

```bash
cd backend
mvn spring-boot:run
```

后端服务将在 `http://localhost:8080` 启动。

#### 3.2 启动前端（开发模式）

```bash
cd frontend

# 安装依赖（首次运行）
npm install

# 启动开发服务器
npm run dev
```

前端开发服务将在 `http://localhost:3000` 启动，通过代理访问后端 API。

### 4. 生产部署

#### 4.1 打包前端

```bash
cd frontend
npm run build
```

打包后的文件会自动输出到 `backend/src/main/resources/static/` 目录。

#### 4.2 打包并运行后端

```bash
cd backend

# 打包（包含前端静态文件）
mvn clean package

# 运行
java -jar target/cms-backend-1.0.0.jar
```

访问 `http://localhost:8080` 即可使用系统。

## 配置说明

### 前端路由模式

本项目使用 Vue Router 的 **Hash 模式**，URL 格式为：
- `http://localhost:8080/#/` - 首页
- `http://localhost:8080/#/login` - 登录页
- `http://localhost:8080/#/content` - 内容列表

**为什么使用 Hash 模式？**
- 前后端不分离时，使用 Hash 模式无需配置服务器路由
- Spring Boot 只需提供 `index.html`，所有路由由前端处理
- 部署简单，不需要 Nginx 配置

### 静态资源配置

Spring Boot 配置类 `WebConfig.java` 负责处理：
1. 静态资源映射到 `classpath:/static/`
2. 根路径 `/` 重定向到 `index.html`
3. API 请求路径 `/api/**` 不受影响

### 安全配置

Spring Security 配置类 `SecurityConfig.java` 负责：
1. OAuth2 登录流程配置
2. 静态资源访问权限（`/`, `/index.html`, `/assets/**` 等无需认证）
3. API 请求需要认证（`/api/**`）
4. 登录页路由：`/#/login`

## API 接口

### 用户相关
- `GET /api/user/info` - 获取当前登录用户信息（需认证）

### 内容相关
- `GET /api/content/list` - 获取内容列表（需认证）
- `GET /api/content/{id}` - 获取单个内容（需认证）
- `POST /api/content/create` - 创建内容（需认证）
- `PUT /api/content/update` - 更新内容（需认证）
- `DELETE /api/content/{id}` - 删除内容（需认证）

### OAuth2 相关
- `GET /api/oauth2/authorization/oauth2` - 发起OAuth2授权请求
- `GET /login/oauth2/code/oauth2` - OAuth2回调地址（自动处理）

## 功能特性

### 用户认证
- OAuth2 单点登录
- 用户信息自动同步
- 会话管理
- Token 自动续期

### 内容管理
- 内容列表查看
- 创建新内容
- 编辑现有内容
- 删除内容
- 内容分类和标签
- 草稿/发布状态管理

### 数据统计
- 浏览次数统计
- 点赞次数统计

## 开发说明

### 后端开发
- 使用 MyBatis 进行数据库操作
- 实体类继承 `BaseEntity`，自动包含审计字段
- 统一使用 `ApiResponse` 返回响应格式
- Controller 使用 `/api` 前缀

### 前端开发
- 使用 TypeScript 进行类型检查
- 使用 Pinia 进行状态管理
- 使用 Vue Router Hash 模式进行路由管理
- 使用 Axios 进行 HTTP 请求
- 开发模式下使用 Vite 代理访问后端

## 前后端分离 vs 不分离对比

| 特性 | 前后端分离 | 前后端不分离 |
|------|-----------|-------------|
| 部署 | 需要部署两个服务 | 只需部署一个服务 |
| 跨域 | 需要配置 CORS | 无跨域问题 |
| 开发 | 可独立开发和部署 | 需要协调部署 |
| 适用场景 | 大型项目、微服务 | 中小型项目 |
| 运维成本 | 较高 | 较低 |

## 常见问题

### Q1: 如何切换回前后端分离模式？

如需切换为前后端分离，需要：
1. 修改 `vite.config.ts`，将 `outDir` 改回 `dist`
2. 修改 `router/index.ts`，使用 `createWebHistory()` 替代 `createWebHashHistory()`
3. 修改 SecurityConfig，添加 CORS 配置
4. 修改 axios baseURL 添加完整后端地址

### Q2: 开发时如何热重载？

开发时运行 `npm run dev`，前端代码修改会自动热重载。
后端代码修改需要重启 Spring Boot 或使用 Spring Boot DevTools。

### Q3: 为什么生产环境只有一个端口？

前后端不分离架构下，Vue 打包后的静态文件集成到 Spring Boot 中，
所有请求都由 Spring Boot 处理，因此只需要一个端口（默认8080）。

## 注意事项

1. 确保已安装 JDK 17 或更高版本
2. 确保已安装 Node.js 18 或更高版本
3. 确保 MySQL 8.0 已安装并启动
4. 确保 OAuth2 服务端正常运行
5. 生产部署前必须执行 `npm run build` 打包前端
6. 修改配置文件中的数据库连接信息和 OAuth2 配置

## 许可证

MIT License
