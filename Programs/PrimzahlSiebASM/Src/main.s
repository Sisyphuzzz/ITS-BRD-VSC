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
mit dem Hexadezimalwert 01 gefüllt

; mittels einer for Schleife, in ASM programiert, 
werden die Adressen von 2 bis 1001 in (JANEIN) angesteuert

; mittels der Fallunterscheidung if wird geprüft, ob die angesteuerte Adresse
den Wert 1 besitzt

; trifft die if Bedingung zu, dann wird eine for Schleife ausgelöst, 
die sämtliche vielfachen der Primzahlen aufruft und deren
Werte zu 0 ändert

-----------Schreiber-----------
; nun wird eine for Schleife erstellt, welche Werte von 2 bis 1001 
aufruft

; in der Schleife befindet sich eine if Bedingung, die überprüft, ob bei einer
Aufgerufenen Adresse der Wert 1 steht

; in der if Bedingung befindet sich eine weitere if Bedingung,
welche sicherstellt, dass die Primzaheln an unterschiedlichen Speicheradressen 
gespeichert werden

; trifft die if Bedingung zu, dann wird in der richtigen Reihenfolge an
die entsprechende Stelle die jeweilige Primzahl geschrieben

END