@echo off
bin\masm asm\%1.asm src\%1 src\%1; > info.txt
bin\link src\%1.obj;
copy %1.exe \src
del %1.exe
cls
cd src
echo debug %1 ing
debug %1.exe

