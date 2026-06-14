;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Franz Korf	
;* Version            : V1.0
;* Date               : 11.05.2022
;* Description        : Rahmen zur Loesung von GTP Woche 7-9 (Stoppuhr).
;
;*******************************************************************************

; Define address of selected GPIO and Timer registers
PERIPH_BASE     	equ	0x40000000                 ;Peripheral base address
AHB1PERIPH_BASE 	equ	(PERIPH_BASE + 0x00020000)
APB1PERIPH_BASE     equ PERIPH_BASE

GPIOD_BASE			equ	(AHB1PERIPH_BASE + 0x0C00)
GPIOF_BASE			equ	(AHB1PERIPH_BASE + 0x1400)
TIM2_BASE           equ (APB1PERIPH_BASE + 0x0000)
	
GPIO_F_PIN        	equ	(GPIOF_BASE + 0x10)

GPIO_D_PIN			equ	(GPIOD_BASE + 0x10)
GPIO_D_SET			equ (GPIOD_BASE + 0x18)
GPIO_D_CLR			equ	(GPIOD_BASE + 0x1A)
	
TIMER				equ (TIM2_BASE + 0x24)   ; CNT : current time stamp (32 bit),  resolution
TIM2_PSC			equ (TIM2_BASE + 0x28)   ; Prescaler  resolution
TIM2_ERG			equ (TIM2_BASE + 0x14)   ; 16 Bit register, Bit 0 : 1 Restart Timer


    EXTERN initITSboard
    EXTERN GUI_init
	EXTERN TP_Init
	EXTERN initTimer
	EXTERN lcdSetFont
	EXTERN lcdGotoXY      		; TFT goto x y function
	EXTERN lcdPrintS			; TFT output function	
    EXTERN lcdPrintC            ; TFT output one character		
	EXTERN Delay				; Delay (ms) function


;********************************************
; Data section, aligned on 4-byte boundery
;********************************************
	AREA MyData, DATA, align = 2

DEFAULT_BRIGHTNESS	DCW     800
zeit				DCB		"00:00.00", 0
zehnerminuten		DCB		0xFF
einerminuten		DCB		0xFF
zehnersekunden		DCB		0xFF
einersekunden		DCB		0xFF
zehnermillisekunden	DCB		0xFF
einermillisekunden	DCB		0xFF

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************
	AREA |.text|, CODE, READONLY, ALIGN = 3


;--------------------------------------------
; main subroutine
;--------------------------------------------
	EXPORT main [CODE]
	
main	PROC

		; Initialisierung der HW
		BL		initITSboard
		ldr   	r1, =DEFAULT_BRIGHTNESS
		ldrh 	r0, [r1]
		bl   	GUI_init
		bl  	initTimer
		ldr 	R1,=TIM2_PSC   			; Set pre scaler such that 1 timer tick represents 10 us
		mov 	R0,#(90*10-1) 
		strh	R0,[R1]
		ldr 	R1,=TIM2_ERG   			; Restart timer	
		mov		R0,#0x01
		strh	R0,[R1]					; Set UG Bit
		MOV 	R0, #24
		bl  	lcdSetFont

		; Ihre Initialisierung
		MOV     R0,#12
        MOV     R1,#6
		BL      lcdGotoXY
		mov     R0,#':'
		BL		lcdPrintC

		MOV     R0,#15
        MOV     R1,#6
		BL      lcdGotoXY
		mov		R0,#'.'
		BL		lcdPrintC
superloop
		MOV     R0,#10
        MOV     R1,#6
		BL      lcdGotoXY
		; Unterprogramm, um den Timer laufen zu lassen
		
		LDR     R0,=TIMER
        LDR     R0,[R0]
		LDR     R1,=60000000
		udiv    R11,R0,R1 ; R11 = zehner min.
		mul     R1,R11,R1
		sub     R0,R0,R1

		LDR     R1,=6000000
		udiv    R4,R0,R1 ; R4 = einer min.
		mul     R1,R4,R1
		sub     R0,R0,R1

		LDR     R1,=1000000
		udiv    R5,R0,R1 ; R5 = zehner sek.
		mul     R1,R5,R1
		sub     R0,R0,R1

		LDR     R1,=100000
		udiv    R6,R0,R1 ; R6 = einer sek.
		mul     R1,R6,R1
		sub     R0,R0,R1

		LDR     R1,=10000
		udiv    R7,R0,R1 ; R7 = zehner millisek.
		mul     R1,R7,R1
		sub     R0,R0,R1

		LDR     R1,=1000
		udiv    R8,R0,R1 ; R8 = einer millisek.
	    add     R11,#'0'
        add     R4,#'0'
		add     R5,#'0'
		add     R6,#'0'
		add     R7,#'0'
		add     R8,#'0'

if_01	LDR		R9,=zehnerminuten
		LDRB	R10,[R9]
		cmp		R10,R11
		beq		endif_01
then_01
		MOV     R0,#10
        MOV     R1,#6
		BL      lcdGotoXY
		mov		R0,R11
		BL		lcdPrintC
		strb	R11, [R9]		

endif_01
if_02	LDR		R9,=einerminuten
		LDRB	R10,[R9]
		cmp		R10,R4
		beq		endif_02
then_02		
		MOV     R0,#11
        MOV     R1,#6
		BL      lcdGotoXY
		mov		R0,R4
		BL		lcdPrintC
		strb	R4, [R9]		

endif_02
if_03	LDR		R9,=zehnersekunden
		LDRB	R10,[R9]
		cmp		R10,R5
		beq		endif_03
then_03
		MOV     R0,#13
        MOV     R1,#6
		BL      lcdGotoXY
		mov		R0,R5
		BL		lcdPrintC
		strb	R5, [R9]		

endif_03
if_04	LDR		R9,=einersekunden
		LDRB	R10,[R9]
		cmp		R10,R6
		beq		endif_04
then_04
		MOV     R0,#14
        MOV     R1,#6
		BL      lcdGotoXY
		mov		R0,R6
		BL		lcdPrintC
		strb	R6, [R9]		

endif_04
if_05	LDR		R9,=zehnermillisekunden
		LDRB	R10,[R9]
		cmp		R10,R7
		beq		endif_05
then_05		
		MOV     R0,#16
        MOV     R1,#6
		BL      lcdGotoXY
		mov		R0,R7
		BL		lcdPrintC
		strb	R7, [R9]		

endif_05
if_06	LDR		R9,=einermillisekunden
		LDRB	R10,[R9]
		cmp		R10,R7
		beq		endif_06
then_06		
		MOV     R0,#17
        MOV     R1,#6
		BL      lcdGotoXY
		mov     R0,R8
		BL		lcdPrintC
		strb	R8, [R9]
endif_06				

		BAL		superloop				; End of superloop
		ENDP

		ALIGN
		END