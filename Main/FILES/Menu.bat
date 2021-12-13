@echo off
 :Start1 
    cls
    goto Start
	
	set "input="
	
    :Start
	COLOR 17
	CLS
    echo --------------------------------------
    echo     WITAJ W PROGRAMIE WindowsTime_2.1  
    echo --------------------------------------            
    echo WYBIERZ NUMER OPCJI Z LISTY PONIZEJ:
    echo [1]	ZAINSTALUJ OGRANICZENIE CZASU
	echo [2]	ODINSTALUJ OGRANICZENIE CZASU
	echo [3]	DODAJ LUB ODEJMIJ CZAS NA DZISIAJ
	echo [4]	ZMIEN CZAS CODZIENNY LUB WEEKENDOWY
	echo [5]	POKAZ AKTUALNY STAN CZASU
	echo [6]	WLACZ LICZNIK RECZNIE
	echo [7]	EXIT

    set /a add=1
	set /a add2=2
	set /a add3=3
	set /a add4=4
	set /a add5=5
	set /a add6=6
	set /a add7=7
	
    set input=
    set /p input= Enter your choice:
	
	GOTO SET_OPERATION
	
	:SET_OPERATION
	
	echo:
	echo:
	set operator=1
	
	IF "%input%" equ "%add%" Set operator=2
	IF "%input%" equ "%add2%" Set operator=2
	IF "%input%" equ "%add3%" Set operator=2
	IF "%input%" equ "%add4%" Set operator=2
	IF "%input%" equ "%add5%" Set operator=2
	IF "%input%" equ "%add6%" Set operator=2
	IF "%input%" equ "%add7%" Set operator=2
	
	GOTO CHECK_LOOP
	
	:CHECK_LOOP
	setlocal enabledelayedexpansion

	IF  %operator% EQU 2 (
	GOTO OPTION_CHOOSEN
	)	else	(
	CLS
	ECHO "MUSISZ PODAC PRAWIDLOWY NUMER OD 1-6"
	GOTO Start1
	)
	
	:OPTION_CHOOSEN
	
	if %input% equ %add% goto A 
	if %input% equ %add2% goto B 
	if %input% equ %add3% goto C 
	if %input% equ %add4% goto D 
	if %input% equ %add5% goto E 
	if %input% equ %add6% goto F
	if %input% equ %add7% goto G

    :A
	CALL %~dp0Main\Options\INSTALL.bat
	GOTO Start
	
	:B
	CALL %~dp0Main\Options\DEINSTALL.BAT
	GOTO Start
	
	:C
	CALL %~dp0Main\Options\change_elasped_time.bat
	GOTO Start
	
	:D
	CALL %~dp0Main\Options\change_time.bat
	GOTO Start
	
	:E
	CALL %~dp0Main\Options\show_aktu_time.bat
	GOTO Start
	
	:F
	
		:ASK_FOR
	
		echo:
		echo:
		set tak=tak
		set nie=nie
		set time_on_or_not=
		set operator_2=1
		echo "CZY CHCES WLACZYC CZAS ? "
		echo:
		set /p "time_on_or_not=NAPISZ: [tak] lub [nie] : "
	
		IF "%time_on_or_not%" == "tak" Set operator_2=2
		IF "%time_on_or_not%" == "nie" Set operator_2=2
	
		GOTO CHECK_answer
	
		:CHECK_answer
		setlocal enabledelayedexpansion

		IF  %operator_2% EQU 2  (
		GOTO Action
		)	else	(
		CLS
		GOTO ASK_FOR
	
		)
		:Action
	
		IF %time_on_or_not% == %tak% ( GOTO START_TIME )
		IF %time_on_or_not% == %nie% ( GOTO NOTIFY )
	
		:START_TIME

		start C:\WindowsTime\Main\help_sc\call_after_kill.vbs
		GOTO Start
	
    :G
    exit
