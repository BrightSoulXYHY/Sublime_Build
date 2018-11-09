@echo off
REM 读取第一个参数
SET param=%1
REM echo %param%
REM REM 不论param有没有双引号，都给其加上
SET param="build.bat %param%"
REM echo %param%

D:/SoftWare/DOSBox-0.74/DOSBox.exe -c %param% -noconsole
