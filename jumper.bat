@echo off
setlocal

:: Convert file to ANSI and clean hidden chars
powershell -noprofile -command "$url = gc '%appdata%\disc\llm\opera.txt' -Raw; $url = $url.Trim(); sc '%appdata%\disc\llm\opera.txt' $url -Encoding Default"

:: Read and display URL
set /p url=<"%appdata%\disc\llm\opera.txt"
echo.
echo [RAW URL CONTENT]
type "%appdata%\disc\llm\opera.txt"
echo.
echo [PROCESSING URL: %url%]
echo.

:: Download with verbose output
curl -v -L "%url%" -o "%appdata%\disc\llm\downloaded_file.txt" --stderr -
echo.
echo Download attempted with exit code: %errorlevel%
pause
