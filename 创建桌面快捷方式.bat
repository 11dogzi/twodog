@echo off
chcp 65001 > nul
setlocal

:: Get desktop path
for /f "tokens=2*" %%a in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do set "DESKTOP_PATH=%%b"

:: Create shortcut using PowerShell with bypass execution policy
powershell.exe -ExecutionPolicy Bypass -Command "$WS = New-Object -ComObject WScript.Shell; $SC = $WS.CreateShortcut('%DESKTOP_PATH%\Comfyui图狗启动器.lnk'); $SC.TargetPath = '%~dp0Comfyui图狗启动器.exe'; $SC.WorkingDirectory = '%~dp0'; $SC.Save()"

if %errorlevel% equ 0 (
    echo Shortcut created successfully!
) else (
    echo Failed to create shortcut!
)

timeout /t 3 