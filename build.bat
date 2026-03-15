@echo off
chcp 65001 >nul
echo ==================================
echo   CMS 项目构建脚本
echo ==================================
echo.

REM 检查是否在项目根目录
if not exist "frontend\package.json" (
    echo 错误：请在项目根目录执行此脚本
    pause
    exit /b 1
)

echo 步骤 1/4: 打包前端...
cd frontend
call npm run build
if errorlevel 1 (
    echo 前端打包失败！
    cd ..
    pause
    exit /b 1
)
echo ✓ 前端打包完成
cd ..

echo.
echo 步骤 2/4: 打包后端...
cd backend
call mvn clean package -DskipTests
if errorlevel 1 (
    echo 后端打包失败！
    cd ..
    pause
    exit /b 1
)
echo ✓ 后端打包完成
cd ..

echo.
echo ==================================
echo   构建完成！
echo ==================================
echo.
echo 运行以下命令启动应用：
echo   cd backend
echo   java -jar target\cms-backend-1.0.0.jar
echo.
echo 访问地址：
echo   http://localhost:8080
echo.
pause
