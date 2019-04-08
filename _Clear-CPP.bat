echo 清理文件
for /f "delims==" %%i in (

'dir /b /s *.exe *.ilk *.obj *.pdb') do (

echo %%i 
del /F %%i
)
REM /f参数使其分析dir命令的输出结果，并用dir 的/s参数搜寻子目录
echo 清理完成
pause