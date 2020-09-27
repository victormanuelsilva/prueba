; CONFIG1
; __config 0xF8F1
 __CONFIG _CONFIG1, _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_ON & _LVP_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF


    LIST p=16F887
    INCLUDE <P16F887.INC>


;***** VARIABLE DEFINITIONS

N EQU 0x00
cont1 EQU 0x20
cont2 EQU 0x21
cont3 EQU 0x22
cont EQU 0x23

    ORG 0x00 ; Inicio de programa
    goto init
 ;**** Configurar el puerto****
init
	bsf STATUS,5 ; Cambia al Banco 1
	movlw 00h ; Configura los pines del puerto B ...
	movwf TRISB ; ...como salidas.
	movwf TRISA ; ...como salidas.

	bcf STATUS,5 ; Vuelve al Banco 0
	movlw 00h ; Configura nuestro registro w con 02h
	movwf PORTB ; ...como salidas.
	movwf PORTA ; ...como salidas.
	movwf cont

MAIN
	MOVLW 05h ; Configura nuestro registro w con 5
	CALL SEVENSEG_LOOKUP
	MOVWF PORTB ;PUT DATA ON PORTB.
	CALL DELAY
	GOTO MAIN	


;--------------------------------------------------------------------------
; NUMBERIC LOOKUP TABLE FOR 7 SEG
;--------------------------------------------------------------------------
SEVENSEG_LOOKUP 
	ADDWF PCL,f
	RETLW 3Fh ; //Hex value to display the number 0.
	RETLW 06h ; //Hex value to display the number 1.
	RETLW 5Bh ; //Hex value to display the number 2.
	RETLW 4Fh ; //Hex value to display the number 3.
	RETLW 66h ; //Hex value to display the number 4.
	RETLW 6Dh ; //Hex value to display the number 5.
	RETLW 7Ch ; //Hex value to display the number 6.
	RETLW 07h ; //Hex value to display the number 7.
	RETLW 7Fh ; //Hex value to display the number 8.
	RETLW 6Fh ; //Hex value to display the number 9.
	RETURN
;**** Aqu� est� nuestra subrutina


DELAY
	MOVLW N
	MOVWF cont1
Rep1
	MOVLW N
	MOVWF cont2
Rep2
	DECFSZ cont2,1
	GOTO Rep2
	DECFSZ cont1,1
	GOTO Rep1
	RETURN ;Retorno a la llamada de rutina de retardo.
;**** Final del programa ****
	end ; Algunos compiladores necesitan esta instrucci�n,
; y tambi�n por si acaso olvidamos poner...
; ... la instrucci�n 'goto'.
	