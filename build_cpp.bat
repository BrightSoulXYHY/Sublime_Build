@echo off
REM 将打开的dos设置为32位编译环境
call "D:\SoftWare\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars32.bat"
cl /EHsc %1.%2
start cmd /c %1.exe
