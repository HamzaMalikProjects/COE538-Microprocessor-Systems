;*****************************************************************
;* This stationery serves as the framework for a                 *
;* user application (single file, absolute assembly application) *
;* For a more comprehensive program that                         *
;* demonstrates the more advanced functionality of this          *
;* processor, please see the demonstration applications          *
;* located in the examples subdirectory of the                   *
;* Freescale CodeWarrior for the HC12 Program directory          *
;*****************************************************************
;*****************************************************************
;*8-bit unsigned numbers multiplication: Hamza Malik 501112545   *      
;*****************************************************************

; export symbols
            XDEF Entry, _Startup     ; export 'Entry' symbol
            ABSENTRY Entry           ; for absolute assembly: mark this as application entry point



; Include derivative-specific definitions 
		INCLUDE 'derivative.inc' 

;********************************************
;*Code Section                              *
;********************************************



            ORG $3000
 
MULTIPLICAND FCB 05       ; First number (5) 
MULTIPLIER   FCB 05       ; Second number (5) 
PRODUCT      RMB 25       ; Result of the Multiplication (5*5=25) "19 in hex"
  
;********************************************
;*Actual program here                       *
;********************************************

            ORG   $4000


Entry:
_Startup:
            LDAA MULTIPLICAND   ; Load the first number into register A
            LDAB MULTIPLIER     ; Load the second number into register B
            MUL                 ; Multiply 8-bit numbers in register A with register B. Store the 16-bit result in register D
            STD PRODUCT         ; Store product in register D 
            SWI                 ; break to the monitor
            
;**************************************************************
;* Interrupt Vectors                                          *
;**************************************************************
            ORG   $FFFE
            FDB   Entry      ;Reset Vector
