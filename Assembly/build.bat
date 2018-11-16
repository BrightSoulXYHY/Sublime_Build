@echo off
REM echo %1
bin\masm asm\%1.asm src\%1 src\%1; > info.txt
REM 若编译失败则退出
if errorlevel 1 GOTO :EOF
bin\link src\%1.obj;
cls
%1.exe
echo=
pause
del %1.exe
:EOF
exit 
