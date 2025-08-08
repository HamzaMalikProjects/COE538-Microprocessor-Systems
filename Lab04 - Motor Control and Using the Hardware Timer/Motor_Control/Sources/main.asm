;*****************************************************************
;* This stationery serves as the framework for a                 *
;* user application (single file, absolute assembly application) *
;* For a more comprehensive program that                         *
;* demonstrates the more advanced functionality of this          *
;* processor, please see the demonstration applications          *
;* located in the examples subdirectory of the                   *
;* Freescale CodeWarrior for the HC12 Program directory          *
;* Hamza Malik 501112545                                         *
;*****************************************************************

; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry        ; for absolute assembly: mark this as application entry point



; Include derivative-specific definitions 
		INCLUDE 'derivative.inc' 

ROMStart    EQU  $4000  ; absolute address to place my code/constant data

; variable/data section

            ORG RAMStart
 ; Insert here your data definition.


; code section
            ORG   ROMStart


Entry:
_Startup:
           
;*****************************************************************                             
;*      Motor Control                                            *
;*                                                               *
;* Sets up direction and speed control for eebot motors using    *
;* PORTA(8-bit register at $0000 to control motor direction) and *
;* PORTT(8-bit register at $0240 to control motor ON/OFF)        *
;*                                                               *
;* Calls 8 subroutines that each control one function:           *
;* turning the motors on/off or changing direction               *
;*****************************************************************

 BSET DDRA,%00000011 ; 3
            BSET DDRT,%00110000  ; 30
            JSR STARFWD
            JSR PORTFWD
            JSR STARON
            JSR PORTON
            JSR STARREV
            JSR PORTREV
            JSR STAROFF                                  
            JSR PORTOFF
            BRA * 
            
STARON      LDAA PTT
            ORAA #%00100000 ;20 
            STAA PTT
            RTS
            
STAROFF     LDAA PTT
            ANDA #%11011111 ; DF - 1315 
            STAA PTT
            RTS

PORTON      LDAA PTT
            ORAA #%00010000  ; 10
            STAA PTT
            RTS
            
PORTOFF     LDAA PTT
            ANDA #%11101111  ;   EF - 1415
            STAA PTT
            RTS

STARFWD     LDAA PORTA
            ANDA #%11111101 ; FD - 1513
            STAA PORTA
            RTS
            
STARREV    LDAA PORTA            
            ORAA #%00000010 ; 2
            STAA PORTA
            RTS


PORTFWD     LDAA PORTA
            ANDA #%11111110  ; FE - 1514
            STAA PORTA
            RTS
            
PORTREV     LDAA PORTA
            ORAA #%00000001   ; 1
            STAA PORTA
            RTS

;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
