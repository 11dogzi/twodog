@echo off
chcp 65001 > nul
setlocal EnableDelayedExpansion

echo 正在更新仓库...

:: 检查git是否安装
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误: 未安装Git! 请先安装Git后再运行此脚本。
    pause
    exit /b 1
)

:: 检查仓库是否已克隆
if not exist .git (
    echo 正在克隆仓库...
    git clone https://github.com/11dogzi/twodog.git .
    if !errorlevel! neq 0 (
        echo 克隆仓库失败！
        pause
        exit /b 1
    )
)

:: 获取当前分支名
for /f "tokens=*" %%a in ('git rev-parse --abbrev-ref HEAD') do set current_branch=%%a

:: 拉取最新更改
git fetch origin
if %errorlevel% neq 0 (
    echo 拉取更新失败！
    pause
    exit /b 1
)

:: 更新当前分支
git pull origin %current_branch%
if %errorlevel% neq 0 (
    echo 更新失败！
    pause
    exit /b 1
)

echo 更新完成！
timeout /t 3