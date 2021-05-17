@echo off
 :Start1 
    cls
    goto Start
	
	set "input="
	
    :Start
	COLOR 17
	CLS
    echo --------------------------------------
    echo     WITAJ W PROGRAMIE WindowsTime_2.0  
    echo --------------------------------------            
    echo WYBIERZ NUMER OPCJI Z LISTY PONIZEJ:
    echo [1]	ZAINSTALUJ OGRANICZENIE CZASU
	echo [2]	ODINSTALUJ OGRANICZENIE CZASU
	echo [3]	DODAJ LUB ODEJMIJ CZAS NA DZISIAJ
	echo [4]	ZMIEN CZAS CODZIENNY LUB WEEKENDOWY
	echo [5]	POKAZ AKTUALNY STAN CZASU
	echo [6]	EXIT

    set /a add=1
	set /a add2=2
	set /a add3=3
	set /a add4=4
	set /a add5=5
	set /a add6=6
	
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
    exit
