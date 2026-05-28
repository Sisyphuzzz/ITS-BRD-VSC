;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Lennard Werner
;* Version            : V1.0
;* Date               : 20.05.2026
;* Description        : PrimzahlSieb in ASM					  
;*******************************************************************************
; Feld (JANEIN) mit 1001 1 Byte Elementen anlegen (DCB)

; Feld (Prim) mit 168 2 Byte Elementen anlegen (DCW)

; --------Beginn des Programms---------
; ------Starten des Hauptprogramms (main)-----

;-----------Sieb------------
; alle 1001 Elemente bis auf das 0. und 1. werden
;mit dem Hexadezimalwert 01 gefüllt

; mittels einer for Schleife, in ASM programiert, 
;werden die Adressen von 2 bis 1001 in (JANEIN) angesteuert

; mittels der Fallunterscheidung if wird geprüft, ob die angesteuerte Adresse
;den Wert 1 besitzt

; trifft die if Bedingung zu, dann wird eine for Schleife ausgelöst, 
;die sämtliche vielfachen der Primzahlen aufruft und deren
;Werte zu 0 ändert

;-----------Schreiber-----------
; nun wird eine for Schleife erstellt, welche Werte von 2 bis 1001 
;aufruft

; in der Schleife befindet sich eine if Bedingung, die überprüft, ob bei einer
;Aufgerufenen Adresse der Wert 1 steht

; in der if Bedingung befindet sich eine weitere if Bedingung,
;welche sicherstellt, dass die Primzaheln an unterschiedlichen Speicheradressen 
;gespeichert werden

; trifft die if Bedingung zu, dann wird in der richtigen Reihenfolge an
;die entsprechende Stelle die jeweilige Primzahl geschrieben

;END

               ;* Beginn der globalen Daten *
                    AREA MyData, DATA, align = 2
Base
Feld                SPACE 1005                

;--------Beginn des Programms---------

    AREA |.text|, CODE, READONLY, ALIGN = 3
                EXPORT main
                EXTERN initITSboard
main            PROC
                bl     initITSboard             

;-------------Feld mit 1 vorbelegen-----------------     

for_01          ldr     R3,=Feld
                mov     R4,#1
                mov     R1,#2
                mov     R2,#1001
until_01        cmp     R1,R2
                beq     enddo_01
do_01           strb    R4,[R3, R1]
step_01         add     R1,R1,#1  
                b       until_01
enddo_01

;------------------Das Sieb--------------------

for_02          mov     R5,#2
until_02        cmp     R5,R2
                beq     enddo_02
do_02           
if_01           ldrb    R0,[R3,R5]
                cmp     R0,R4
                blo     else_01
then_01         
for_03          mul     R6,R5,R5
                mov     R7,#0
until_03        cmp     R6,R2
                bhs     enddo_03
do_03           strb    R7,[R3,R6]
step_03         add     R6,R6,R5
                b       until_03
enddo_03
                b       endif_01
else_01    
endif_01
step_02         add     R5,R5,#1
                b       until_02
enddo_02

forever         b   forever
                ENDP
                END