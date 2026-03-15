#!/bin/bash

echo "=================================="
echo "  CMS 开发环境启动脚本"
echo "=================================="
echo ""

# 检查依赖
if ! command -v java &> /dev/null; then
    echo "错误：未找到 Java，请先安装 JDK 17 或更高版本"
    exit 1
fi

if ! command -v mvn &> /dev/null; then
    echo "错误：未找到 Maven，请先安装 Maven"
    exit 1
fi

if ! command -v node &> /dev/null; then
    echo "错误：未找到 Node.js，请先安装 Node.js 18 或更高版本"
    exit 1
fi

# 启动后端
echo "启动后端服务..."
cd backend
mvn spring-boot:run > /dev/null 2>&1 &
BACKEND_PID=$!
echo "后端服务启动中 (PID: $BACKEND_PID)"
cd ..

# 等待后端启动
echo "等待后端服务就绪..."
sleep 10

# 启动前端
echo "启动前端开发服务..."
cd frontend
npm run dev &
FRONTEND_PID=$!
echo "前端服务启动中 (PID: $FRONTEND_PID)"
cd ..

echo ""
echo "=================================="
echo "  服务启动完成！"
echo "=================================="
echo ""
echo "前端地址：http://localhost:3000"
echo "后端地址：http://localhost:8080"
echo ""
echo "按 Ctrl+C 停止所有服务"
echo ""

# 捕获中断信号，清理进程
trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; echo ''; echo '服务已停止'; exit 0" INT TERM

# 保持脚本运行
wait
