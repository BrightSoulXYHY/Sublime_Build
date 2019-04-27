@echo off
REM 将打开的dos设置为32位编译环境
REM 输入参数为文件夹名字"${fileDirname}",获取当前目录名
call "D:\SoftWare\Microsoft Visual Studio\VC\Auxiliary\Build\vcvars32.bat" > F:\Progroming\C++\info.txt

set "f_path=%cd%"
set "f_path=%f_path:\= %"
for %%a in (%f_path%) do set f_name=%%a
echo [32m文件夹是:%f_name%[0m



cl /Od /Zi /EHsc *.cpp /Fe:%f_name%.exe>> F:\Progroming\C++\info.txt
if errorlevel 1 GOTO :Err
echo [32mrun %f_name%.exe
echo [0m
copy %f_name%.exe  %1.exe > nul
%f_name%.exe 


:Err
cd F:\Progroming\C++
echo [93m
findstr "error" info.txt
if EXIST info_ed.TXT del info_ed.TXT
ren info.TXT info_ed.TXT