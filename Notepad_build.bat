@echo off
REM F:\Progroming\_Path\Notepad_build.bat $(NAME_PART) $(EXT_PART) & pause
REM echo %1
REM echo %2

if %2 == .bat (%1.bat) 
if %2 == .py (python -u %1.py) 


