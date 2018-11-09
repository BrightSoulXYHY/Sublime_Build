@echo off
REM echo %1
masm %1.asm;
link %1.obj;
cls
%1.exe
pause
exit