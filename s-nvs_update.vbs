Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell -ExecutionPolicy Bypass -File ""%appdata%\nvd_s\dt\nvs_update.ps1""", 0, True
