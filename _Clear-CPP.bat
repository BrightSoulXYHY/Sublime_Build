echo �����ļ�
for /f "delims==" %%i in (

'dir /b /s *.exe *.ilk *.obj *.pdb') do (

echo %%i 
del /F %%i
)
REM /f����ʹ�����dir�����������������dir ��/s������Ѱ��Ŀ¼
echo �������
pause