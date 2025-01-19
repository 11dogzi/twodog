@echo off
chcp 65001 >nul
title Comfyui图狗启动器 - 下载程序
color 0A

echo [信息] 正在准备下载 Comfyui图狗启动器...
echo [信息] 当前使用 UTF-8 编码以支持中文显示
echo.

:: 检查是否存在 curl
where curl >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [提示] 未找到 curl 下载工具，将使用 PowerShell 方式下载...
    goto use_powershell
)

:use_curl
echo [信息] 正在使用 curl 下载工具...
echo [信息] 如果下载失败会自动切换到 PowerShell 方式
curl -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" ^
     --retry 5 --retry-delay 3 --retry-max-time 60 ^
     --connect-timeout 30 --max-time 600 ^
     -o "Comfyui图狗启动器.exe" ^
     "https://github.com/11dogzi/twodog/raw/main/Comfyui图狗启动器.exe"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [成功] 下载完成！文件已保存为：Comfyui图狗启动器.exe
    goto end
) else (
    echo [错误] curl 下载失败，正在切换到备用下载方式...
    goto use_powershell
)

:use_powershell
echo [信息] 正在使用 PowerShell 方式下载...
powershell -ExecutionPolicy Bypass -NoProfile -Command ^
"$OutputEncoding = [Console]::OutputEncoding = [Text.Encoding]::UTF8; & {
    try {
        Write-Host '[信息] 正在设置下载参数...'
        $url = 'https://github.com/11dogzi/twodog/raw/main/Comfyui图狗启动器.exe'
        $outFile = Join-Path (Get-Location) 'Comfyui图狗启动器.exe'
        
        Write-Host '[信息] 开始下载文件...'
        $webClient = New-Object System.Net.WebClient
        $webClient.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)')
        $webClient.DownloadFile($url, $outFile)
        
        Write-Host '[成功] 下载完成！'
        exit 0
    } catch {
        Write-Host '[错误] ' $_.Exception.Message
        exit 1
    }
}"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [成功] 下载过程已完成！
) else (
    echo.
    echo [错误] 下载失败，请查看上方错误信息。
)

:end
echo.
echo [信息] 按任意键退出...
pause >nul 