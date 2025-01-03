@echo off
chcp 65001 > nul
setlocal
for /f "tokens=2*" %%a in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do set "DESKTOP_PATH=%%b"
copy /Y "%~dp0Comfyui图狗启动器.exe" "%DESKTOP_PATH%\Comfyui图狗启动器.exe" > nul
if %errorlevel% equ 0 (
    echo 快捷方式已创建成功！
) else (
    echo 创建快捷方式失败！
)

timeout /t 3