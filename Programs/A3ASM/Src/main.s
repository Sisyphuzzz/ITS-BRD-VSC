;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base
VariableA          DCW 0x1234
VariableB          DCW 0x4711

VariableC          DCD  0

MeinHalbwortFeld   DCW 0x22 , 0x3e , -52, 78 , 0x27 , 0x45

MeinWortFeld       DCD 0x12345678 , 0x9dca5986
                   DCD -872415232 , 1308622848
                   DCD 0x27000000
                   DCD 0x45000000

MeinTextFeld       DCB "ABab0123",0

                   EXPORT VariableA
                   EXPORT VariableB
                   EXPORT VariableC
                   EXPORT MeinHalbwortFeld
                   EXPORT MeinWortFeld
                   EXPORT MeinTextFeld

;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard
main            PROC
                bl    initITSboard                 ; HW Initialisieren

; Laden von Konstanten in Register
                ;  schreibe den Wert "0x12" in das Register r0
                mov   r0,#0x12                      ; Anw-01
                ; schreibe den Dezimalwert "-128", welcher im Register als Hexadezimalwert "0xffffff80" angezeigt wird in das Register r1 
                mov   r1,#-128                      ; Anw-02
                ; schreibe in das Register 2 den Wert "0x12345678"
                ldr   r2,=0x12345678                ; Anw-03

; Zugriff auf Variable
                ; schreibe in r0 die Adresse, der zuvor bestimmten "VariableA"
                ldr   r0,=VariableA                 ; Anw-04
                ; lade die ersten zwei Bytes, die auf der Adresse "VariableA" stehen in r1
                ldrh  r1,[r0]                       ; Anw-05
                ; lade die ersten 4 Bytes, die auf der Adresse "VariableA" stehen in r2
                ldr   r2,[r0]                       ; Anw-06
                ; lade den Wert, der in Register 2 steht an die Speicheradresse von Variable C 
                str   r2,[r0,#VariableC-VariableA]  ; Anw-07

; Zugriff auf Felder (Speicherzellen)
                ; lade in Register 0 die Adresse von "MeinHalbwortFeld"
                ldr   r0,=MeinHalbwortFeld          ; Anw-08
                ; lade die ersten 2 Bytes von "MeinHalbwortFeld" in Register 1
                ldrh  r1,[r0]                       ; Anw-09
                ;lade 2 Bytes, 2 Bytes im Speciher von "MeinHalbwortFeld" verschoben in Register 2
                ldrh  r2,[r0,#2]                    ; Anw-10
                ; schreibe den dezimalwert "10" in Register r3
                mov   r3,#10                        ; Anw-11
                ; es werden die 2 Bytes geladen, die sich 10 Bytes von "MeinHalbwortFeld" entfernt befinden
                ldrh  r4,[r0,r3]                    ; Anw-12

                ;lade 2 Bytes, 2 Bytes entfernt von "MeinHalbwortFeld" in r5 nd verschiebe die Adresse von r0 zwei Bytes nach rechts
                ldrh  r5,[r0,#2]!                   ; Anw-13
                ;lade 2 Bytes der verschobenen Adresse in r6 und verchiebe die Adresse um 2 bytes nach rechts
                ldrh  r6,[r0,#2]!                   ; Anw-14
                ; lade 2 Bytes, der gerade verschobenen Adresse in r6 und verschiebe diese um weitere 2 Bytes
                strh  r6,[r0,#2]!                   ; Anw-15

; Addition und Subtraktion von unsigned / signed Integer-Werten
                ; lade in r0 die Adresse von "MeinWortFeld"
                ldr  r0,=MeinWortFeld               ; Anw-16
                ; lade die ersten 4 Bytes von "MeinWortFeld in r1
                ldr  r1,[r0]                        ; Anw-17
                ; lädt 4 Bytes, 4 Bytes verschoben von r0 in r2
                ldr  r2,[r0,#4]                     ; Anw-18
                ; r1 und r2 werden addiert und Flag wird gesetzt
                adds r3,r1,r2                       ; Anw-19
                
                ; lade in Register 4 die 4 Bytes, 8 Bytes von r0 verschoben
                ldr  r4,[r0,#8]                     ; Anw-20
                ;lade in r5 die 4 Bytes, 12 Bytes von r0 verschoben
                ldr  r5,[r0,#12]                    ; Anw-21
                ;subtrahiere r5 von r4 und setzte flag
                subs r6,r4,r5                       ; Anw-22

                ;lade in r7 4 Bytes, 16 bytes von r0 nach rechts verschoben
                ldr  r7,[r0,#16]                    ; Anw-23
                ; lade in r8 4 Bytes, 20 Bytes von r0 nach rechts verschoben
                ldr  r8,[r0,#20]                    ; Anw-24
                ;subtrahiere r8 von r7 und setzte Flag
                subs r9,r7,r8                       ; Anw-25

                ;Endlosschlefe wird erzeugt mit unbedingtem Sprung
forever         b   forever                         ; Anw-26
                ENDP
                END   