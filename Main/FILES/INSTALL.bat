@echo off
COLOR 57
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

CLS
for /f "tokens=*" %%a in ('powershell -Command "Get-Date -format 'dd.MM.yy'"') do set TODAY=%%a
SET dir=%~dp0
set identity=%username%
GOTO WELCOME
:WELCOME
echo:
echo 				     "WITAJ. TU TWOJ CZASOWY WYLACZNIK KOMPUTERA"

echo:
GOTO CHOOSE_1
echo:
	:CHOOSE_1
echo:

	wmic UserAccount get Name
	set user_id=
	set /p "user_id=PODAJ NAZWE UZYTKOWNIKA DLA KTOREGO CHCESZ USTAWIC CZAS Z LISTY U GORY: "
	)
	GOTO CREATE_LOG
	
	:CREATE_LOG

	IF exist "c:\Users\%user_id%\LOG" ( 
		GOTO HISTORY_FILE_0
		)	ELSE	(
		mkdir "c:\Users\%user_id%\LOG"
		)

	GOTO HISTORY_FILE_0

	:HISTORY_FILE_0

	IF exist c:\Users\%user_id%\LOG\History0 ( 
		GOTO HISTORY_FILE_1 
		)	ELSE (
		echo %TODAY% > c:\Users\%user_id%\LOG\History0
		echo  0 >> c:\Users\%user_id%\LOG\History0
	)
	GOTO HISTORY_FILE_1
	
	:HISTORY_FILE_1
	IF exist c:\Users\%user_id%\LOG\History1 ( 
		GOTO HISTORY_FILE_2 
		)	ELSE (
		echo %TODAY% > c:\Users\%user_id%\LOG\History1
		echo  0 >> c:\Users\%user_id%\LOG\History1
	)
	GOTO HISTORY_FILE_2
	
	:HISTORY_FILE_2
	IF exist c:\Users\%user_id%\LOG\History2 ( 
		GOTO HISTORY_FILE_3 
		)	ELSE (
		echo %TODAY% > c:\Users\%user_id%\LOG\History2
		echo  0 >> c:\Users\%user_id%\LOG\History2
	)
	GOTO HISTORY_FILE_3
	
	:HISTORY_FILE_3
	IF exist c:\Users\%user_id%\LOG\History3 ( 
		GOTO HISTORY_FILE_4 
		)	ELSE (
		echo %TODAY% > c:\Users\%user_id%\LOG\History3
		echo  0 >> c:\Users\%user_id%\LOG\History3
	)
	GOTO HISTORY_FILE_4
	
	:HISTORY_FILE_4
	IF exist c:\Users\%user_id%\LOG\History4 ( 
		GOTO SET_RANDOM 
		)	ELSE (
		echo %TODAY% > c:\Users\%user_id%\LOG\History4
		echo  0 >> c:\Users\%user_id%\LOG\History4
	)	
	GOTO SET_RANDOM
	
	:SET_RANDOM
	setlocal enabledelayedexpansion
	set /a num=0
	set /a num=%random% %%04
	
	IF exist c:\Users\%user_id%\LOG\RANDOM ( 
		GOTO WINDOWS_TIME_DIR 
		)	ELSE (
		echo !num!>c:\Users\%user_id%\LOG\encoded
	
		certutil -encode "c:\Users\%user_id%\LOG\encoded" "c:\Users\%user_id%\LOG\RANDOM" >nul 2>nul
		DEL c:\Users\%user_id%\LOG\encoded

		GOTO WRITE_HASH
		:WRITE_HASH
		set /a count=1 
		for /f "skip=1 delims=:" %%a in ('CertUtil -hashfile c:\Users\%user_id%\LOG\History%num% MD5') do (
			if !count! equ 1 set "md5=%%a"
			set/a count+=1
		)
		set "md5=%md5: =%
		echo !md5!>c:\Users\%user_id%\LOG\HASH
		ENDLOCAL
	)
	
	GOTO WINDOWS_TIME_DIR

	:WINDOWS_TIME_DIR
	IF exist c:\WindowsTime ( 
		GOTO NOTIFY 
		)	ELSE (
		mkdir c:\WindowsTime 
	)
	
	GOTO NOTIFY
	
	:NOTIFY

	IF exist C:\WindowsTime\Main\Notify ( 
		GOTO help_sc 
		)	ELSE (
		MKDIR C:\WindowsTime\Main\Notify
		
	)
	
	GOTO help_sc
	
	:help_sc
	IF exist \WindowsTime\Main\help_sc ( 
		GOTO WINDOWS_TIME_CONFIG_DIR 
		)	ELSE (
		mkdir \WindowsTime\Main\help_sc 
	)
	
	GOTO WINDOWS_TIME_CONFIG_DIR
	
	:WINDOWS_TIME_CONFIG_DIR
	IF exist c:\WindowsTime\Config ( 
		GOTO WINDOWS_TIME_CONTENT_COPY_AND_PERMISSION_SET 
		)	ELSE (
		mkdir c:\WindowsTime\Config 
	)
	
	GOTO OPTIONS
	
	:OPTIONS
	IF exist c:\WindowsTime\Main\Options ( 
		GOTO WINDOWS_TIME_CONTENT_COPY_AND_PERMISSION_SET 
		)	ELSE (
		mkdir c:\WindowsTime\Main\Options
	)

	GOTO WINDOWS_TIME_CONTENT_COPY_AND_PERMISSION_SET

	:WINDOWS_TIME_CONTENT_COPY_AND_PERMISSION_SET
	
	copy "C:\WindowsTime\Config\config.ini" C:\Users\%user_id%\LOG\

	
	icacls c:\Users\%user_id%\LOG\ /inheritance:r /t
	icacls c:\Users\%user_id%\LOG\ /grant "%identity%":(OI)(CI)F /inheritance:r /t
	icacls c:\Users\%user_id%\LOG\ /deny *S-1-1-0:(DE)
	icacls c:\Users\%user_id%\LOG\ /grant *S-1-1-0:(OI)(CI)(M) /t
	icacls c:\Users\%user_id%\LOG\config.ini /grant "%identity%":F /inheritancer:r
	icacls c:\Users\%user_id%\LOG\config.ini /grant *S-1-1-0:(RX)
	icacls c:\Users\%user_id%\LOG\History0 /grant *S-1-1-0:(F)
	icacls c:\Users\%user_id%\LOG\History1 /grant *S-1-1-0:(F)
	icacls c:\Users\%user_id%\LOG\History2 /grant *S-1-1-0:(F)
	icacls c:\Users\%user_id%\LOG\History3 /grant *S-1-1-0:(F)
	icacls c:\Users\%user_id%\LOG\History4 /grant *S-1-1-0:(F)
	icacls c:\Users\%user_id%\LOG\HASH /grant *S-1-1-0:F
	icacls c:\Users\%user_id%\LOG\RANDOM /grant *S-1-1-0:(F)
	
	
	GOTO STARTUP

	:STARTUP
	
	copy "C:\WindowsTime\Main\Notify\initiate.vbs" "C:\Users\%user_id%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
	TAKEOWN	/f	"C:\Users\%user_id%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"	/r /d y
	icacls		"C:\Users\%user_id%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"	/reset /T
	icacls		"C:\Users\%user_id%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"	/grant:r "%identity%":(OI)(CI)F
	icacls		"C:\Users\%user_id%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"	/grant:r "%user_id%":(OI)(CI)R
	icacls		"C:\Users\%user_id%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"	/inheritance:r
	
	cmd /c "echo.>"C:\Users\%user_id%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\initiate.vbs:Zone.Identifier"

	
	timeout 2
	echo "CZAS ZOSTAL ZAINSTALOWANY DLA %user_id% !. STANDARDOWO DLA UZYTKOWNIKA JEST USAWIONZ CZAS: Pon-Pt 1 godz.. So-Nd 1,5 godz." > C:\WindowsTime\Main\Notify\notify2_vbs_notification
	start C:\WindowsTime\Main\Notify\notify2.vbs
	
	GOTO ADD_TASKMGR_DI
	
	:ADD_TASKMGR_DI
	reg load HKLM\TempHive C:\Users\%user_id%\ntuser.dat

	REG.EXE ADD HKLM\TempHive\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\	/v DisableTaskmgr /t REG_DWORD /d 1 /f
	
	
	GOTO END

:END

DEL %dir%help_sc\users.txt
DEL %dir%help_sc\users2.txt
DEL %dir%help_sc\users3.txt
DEL %dir%help_sc\unblock.ps1
