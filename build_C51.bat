@echo off
D:\SoftWare\Keil_v5\C51\BIN\C51 %1.c > F:\Progroming\51\info.txt
if errorlevel 1 GOTO :Err
D:\SoftWare\Keil_v5\C51\BIN\BL51 %1.obj >> F:\Progroming\51\info.txt
D:\SoftWare\Keil_v5\C51\BIN\OH51 %1 >> F:\Progroming\51\info.txt

:Err
cd F:\Progroming\51
findstr /a:04 "ERROR WARNING" *info.txt

echo [32m
findstr /a:02 "GENERATING" *info.txt
if EXIST info_ed.TXT del info_ed.TXT
ren info.TXT info_ed.TXT

cd %2
del %1 %1.lst %1.m51 %1.obj
move %1.hex F:\Progroming\51\_build\%date:~0,4%%date:~5,2%%date:~8,2%-%1.hex > nul
echo At F:\Progroming\51\_build\%date:~0,4%%date:~5,2%%date:~8,2%-%1.hex