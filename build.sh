#!/bin/bash

echo "=================================="
echo "  CMS 项目构建脚本"
echo "=================================="
echo ""

# 检查是否在项目根目录
if [ ! -f "package.json" ] && [ ! -f "pom.xml" ]; then
    echo "错误：请在项目根目录执行此脚本"
    exit 1
fi

echo "步骤 1/4: 打包前端..."
cd frontend
npm run build
if [ $? -ne 0 ]; then
    echo "前端打包失败！"
    exit 1
fi
echo "✓ 前端打包完成"
cd ..

echo ""
echo "步骤 2/4: 打包后端..."
cd backend
mvn clean package -DskipTests
if [ $? -ne 0 ]; then
    echo "后端打包失败！"
    exit 1
fi
echo "✓ 后端打包完成"
cd ..

echo ""
echo "=================================="
echo "  构建完成！"
echo "=================================="
echo ""
echo "运行以下命令启动应用："
echo "  cd backend"
echo "  java -jar target/cms-backend-1.0.0.jar"
echo ""
echo "访问地址："
echo "  http://localhost:8080"
echo ""
