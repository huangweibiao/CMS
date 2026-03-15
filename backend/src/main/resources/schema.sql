-- 创建数据库
CREATE DATABASE IF NOT EXISTS cms DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE cms;

-- 用户表
CREATE TABLE IF NOT EXISTS user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    email VARCHAR(100) COMMENT '邮箱',
    nickname VARCHAR(50) COMMENT '昵称',
    avatar VARCHAR(255) COMMENT '头像',
    oauth2_id VARCHAR(100) COMMENT 'OAuth2用户ID',
    oauth2_provider VARCHAR(50) COMMENT 'OAuth2提供商',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted TINYINT DEFAULT 0 COMMENT '删除标志',
    create_by VARCHAR(50) DEFAULT 'system' COMMENT '创建人',
    update_by VARCHAR(50) DEFAULT 'system' COMMENT '更新人',
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_oauth2_id (oauth2_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- 内容表
CREATE TABLE IF NOT EXISTS content (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '内容ID',
    title VARCHAR(200) NOT NULL COMMENT '标题',
    content TEXT COMMENT '内容',
    category VARCHAR(50) COMMENT '分类',
    tags VARCHAR(200) COMMENT '标签',
    status VARCHAR(20) DEFAULT 'draft' COMMENT '状态：draft-草稿, published-已发布',
    author_id BIGINT COMMENT '作者ID',
    author_name VARCHAR(50) COMMENT '作者名称',
    view_count INT DEFAULT 0 COMMENT '浏览次数',
    like_count INT DEFAULT 0 COMMENT '点赞次数',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted TINYINT DEFAULT 0 COMMENT '删除标志',
    create_by VARCHAR(50) DEFAULT 'system' COMMENT '创建人',
    update_by VARCHAR(50) DEFAULT 'system' COMMENT '更新人',
    INDEX idx_status (status),
    INDEX idx_author_id (author_id),
    INDEX idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='内容表';
