@echo off
REM 传入参数为
REM "${fileBasenameNoExtension}"               
REM "${fileDirname}" 完整路径
D:\SoftWare\Keil_v5\C51\BIN\C51 %1.c > F:\Progroming\51\info.txt
if errorlevel 1 GOTO :Err
D:\SoftWare\Keil_v5\C51\BIN\BL51 %1.obj >> F:\Progroming\51\info.txt
D:\SoftWare\Keil_v5\C51\BIN\OH51 %1 >> F:\Progroming\51\info.txt




cd F:\Progroming\51
REM 黄色warring
echo [93m
findstr /c:"\*\*\* WARNING" info.txt
REM 绿色complete
echo [32m
findstr "COMPLETE" info.txt

if EXIST info_ed.TXT del info_ed.TXT
ren info.TXT info_ed.TXT

echo [96m
cd %2
del %1 %1.lst %1.m51 %1.obj
move %1.hex F:\Progroming\51\_build\%date:~0,4%%date:~5,2%%date:~8,2%-%1.hex > nul
echo At F:\Progroming\51\_build\%date:~0,4%%date:~5,2%%date:~8,2%-%1.hex

GOTO :EOF

:Err
cd F:\Progroming\51
echo [93m
findstr /c:"*** ERROR" info.txt
echo [91m
findstr "COMPLETE" info.txt



