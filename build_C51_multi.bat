@echo off
REM ÊäÈë²ÎÊýÎªÎÄ¼þ¼ÐÃû×Ö"${workspaceFolderBasename}"
REM ±àÒë
for /f "delims==" %%i in (
'dir /b  *.c') do (
D:\SoftWare\Keil_v5\C51\BIN\C51 %%i > F:\Progroming\51\info.txt
if errorlevel 1 GOTO :Err
>>~temp<nul set /p=%%~ni.obj,
)
REM È¥³ý×îÄ©Î²µÄ¶ººÅ
sed "s/,$//g" "~temp" > "~temp1"
REM echo %OEM%
set /P OEM=<~temp1
del ~*

D:\SoftWare\Keil_v5\C51\BIN\bl51 %OEM% TO %1.out >> F:\Progroming\51\info.txt
D:\SoftWare\Keil_v5\C51\BIN\OH51 %1.out >> F:\Progroming\51\info.txt




cd F:\Progroming\51
REM »ÆÉ«warring
echo [93m
findstr /c:"\*\*\* WARNING" info.txt
REM ÂÌÉ«complete
echo [32m
findstr "COMPLETE" info.txt

if EXIST info_ed.TXT del info_ed.TXT
ren info.TXT info_ed.TXT

echo [96m
cd %2
del *.lst *.m51 *.obj *.map *.out
move %1.hex F:\Progroming\51\_build\%date:~0,4%%date:~5,2%%date:~8,2%-%1.hex > nul
echo At F:\Progroming\51\_build\%date:~0,4%%date:~5,2%%date:~8,2%-%1.hex

GOTO :EOF

:Err
cd F:\Progroming\51
echo [93m
findstr /c:"*** ERROR" info.txt
echo [91m
findstr "COMPLETE" info.txt