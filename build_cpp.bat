@echo off
REM 将打开的dos设置为32位编译环境

call "D:\SoftWare\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars32.bat" > F:\Progroming\C++\info.txt
cl /EHsc %1.%2 >> F:\Progroming\C++\info.txt
if errorlevel 1 GOTO :Err
start /WAIT cmd /c %1.exe 
del %1.obj
del %1.exe

:Err
cd F:\Progroming\C++
findstr "error" info.txt
if EXIST info_ed.TXT del info_ed.TXT
ren info.TXT info_ed.TXT

