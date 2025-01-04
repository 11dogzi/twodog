@echo off
chcp 65001 > nul
setlocal

:: 获取桌面路径
for /f "tokens=2*" %%a in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do set "DESKTOP_PATH=%%b"

:: 创建快捷方式
powershell.exe -Command "$WS = New-Object -ComObject WScript.Shell; $SC = $WS.CreateShortcut('%DESKTOP_PATH%\Comfyui图狗启动器.lnk'); $SC.TargetPath = '%~dp0Comfyui图狗启动器.exe'; $SC.WorkingDirectory = '%~dp0'; $SC.Save()"

if %errorlevel% equ 0 (
    echo 快捷方式已创建成功！
) else (
    echo 创建快捷方式失败！
)

timeout /t 3