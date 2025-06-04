@echo off
setlocal
powershell -noprofile -command "$url = gc '%appdata%\disc\llm\opera.txt' -Raw; $url = $url.Trim(); sc '%appdata%\disc\llm\opera.txt' $url -Encoding Default"
set /p url=<"%appdata%\disc\llm\opera.txt"
type "%appdata%\disc\llm\opera.txt"
curl -v -L "%url%" -o "%appdata%\disc\llm\downloaded_file.txt" --stderr -
pause
