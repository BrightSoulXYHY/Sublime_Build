@echo off
REM 将打开的dos设置为32位编译环境

call "D:\SoftWare\Microsoft Visual Studio\VC\Auxiliary\Build\vcvars32.bat" > F:\Progroming\C++\info.txt
rem cl /EHsc %1.cpp
rem %1.exe 

cl /Od /Zi /EHsc %1.cpp >> F:\Progroming\C++\info.txt
if errorlevel 1 GOTO :Err
%1.exe 


:Err
cd F:\Progroming\C++
findstr "error" info.txt
if EXIST info_ed.TXT del info_ed.TXT
ren info.TXT info_ed.TXT