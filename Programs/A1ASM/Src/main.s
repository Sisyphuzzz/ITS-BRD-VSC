;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Praktikum          : GTP
;* Aufgaben-Nr        : Aufgabe A1
;* Namen              : Lennard Werner 2880253
;*                    : Yannick Funk 2875549
;
;*******************************************************************************
    EXTERN initITSboard ; Helper to organize the setup of the board

    EXPORT main         ; we need this for the linker
                        ;- In this context it set the entry point,too

; setup the peripherie - Mapping the GPIO
PERIPH_BASE         equ 0x40000000
AHB1PERIPH_BASE     equ (PERIPH_BASE + 0x00020000)
GPIOD_BASE          equ (AHB1PERIPH_BASE + 0x0C00)

GPIO_D_SET          equ (GPIOD_BASE + 0x18)
GPIO_D_CLR          equ (GPIOD_BASE + 0x1A)
;* We need minimal memory setup of InRootSection placed in Code Section
    AREA  |.text|, CODE, READONLY, ALIGN = 3
    ALIGN
main
     BL initITSboard            ; needed by the board to setup
    LDR     R6, =GPIO_D_SET     ; get address of the GPIO data set register
    MOV     R8, #2_0011         ; load mask 0b0011
 
    ; Set LED
    STRB    R8, [R6]    ; LED D08 + D09 anschalten 
    b .
    
    ALIGN
    END
