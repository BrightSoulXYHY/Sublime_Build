@echo off
REM 读取第一个参数
REM echo %1 %2
SET param=%1

REM REM 不论param有没有双引号，都给其加上
if %2 == 1 (SET param="build.bat %param%")
if %2 == 2 (SET param="debug.bat %param%")

REM if %2 == 1 (echo "build.bat %param%")
REM if %2 == 2 (echo "debug.bat %param%")


D:/SoftWare/DOSBox-0.74/DOSBox.exe -c %param% -noconsole

REM 增加查询报错信息部分
cd F:\Progroming\Assemble
findstr "error" INFO.TXT
findstr "Errors" INFO.TXT
if EXIST INFO_ED.TXT del INFO_ED.TXT
ren INFO.TXT INFO_ED.TXT