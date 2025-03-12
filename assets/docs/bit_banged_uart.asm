    PROCESSOR	10F322
    RADIX	DEC
    
    config FOSC = INTOSC    ; Oscillator Selection bits (INTOSC oscillator: CLKIN function disabled)
    config BOREN = OFF      ; Brown-out Reset Enable (Brown-out Reset disabled)
    config WDTE = OFF       ; Watchdog Timer Enable (WDT disabled)
    config PWRTE = ON       ; Power-up Timer Enable bit (PWRT enabled)
    config MCLRE = ON       ; MCLR Pin Function Select bit (MCLR pin function is RESET input)
    config CP = OFF         ; Code Protection bit (Program memory code protection is disabled)
    config LVP = ON         ; Low-Voltage Programming Enable (Low-voltage programming enabled)
    config LPBOR = OFF      ; Brown-out Reset Selection bits (BOR disabled)
    config BORV = LO        ; Brown-out Reset Voltage Selection (Brown-out Reset Voltage (Vbor), low trip point selected.)
    config WRT = OFF        ; Flash Memory Self-Write Protection (Write protection off)

; This include file pulls in the proper definitions for the registers for this processor   
#include <xc.inc>
	
; This PSECT command specifies that we want to locate variables in Bank0   
    PSECT   udata_bank0

; We make them GLOBAL to help the debugger find them, that's all
    GLOBAL  TR_BYTE_REG, TR_COUNTER, DONE_TR_FLAG, RX_RECEIVE_REG, RX_COUNTER, DONE_RX_FLAG
; Transmit Variables
TR_BYTE_REG:	    DS  1   ; Reserve 1 byte for data
TR_COUNTER:         DS  1   ; Reserve 1 byte for counter
DONE_TR_FLAG:	    DS  1   ; Reserve 1 byte for transmit done flag
; Receive Variables
RX_RECEIVE_REG:	    DS	1   ; Reserve 1 byte for received data   
RX_COUNTER:         DS	1   ; Reserve 1 byte for the counter used in receiving
DONE_RX_FLAG:	    DS	1   ; Reserve 1 byte for the done with receive flag

;
;   Data space used by interrupt handler to save context is
;   placed at the top of bank 0 for upward compatibility
    PSECT   Isr_data,global,class=RAM,space=1,delta=1,noexec
;
    GLOBAL  WREG_save,STATUS_save
;
WREG_save:      DS  1
STATUS_save:    DS  1

;   Symbols/Tables to use in lab 9
BitsPerByte         equ     8
NumStopBits         equ     1
NumBitsToTransmit   equ     9
INCR_REG_NCO_2400   equ	    157	    ;(equation 20-1)
PR2_REG_2400	    equ	    104
PR2_REG_2400_Start  equ	    156	    

; This PSECT command is used to locate code. The actual address is specifed
; in the project properties box "pic-as Global Options -> Additional options"
; Be sure to add this line there : 
;   -Wa,-a -Wl,-DCODE=2,-pReset_Vec=00h,-pISR_Vec=04h,-pIsr_data=07eh,-Map=test.map    
    PSECT   Reset_Vec,class=CODE,delta=2
    
; The GLOBAL declaration is not strictly necessary in a single module program.    
    GLOBAL  ResetVector
ResetVector:
	goto	Main

; This PSECT places the ISR handler at the ISR_Vec address in the additional
; options line shown earlier. For this processor this needs to be at address 04h
    PSECT   ISR_Vec,class=CODE,delta=2
    
; ******* ISR ROUTINES *******    
ISR_Vector:
; start off by saving the context
    movwf   WREG_save
    swapf   STATUS,W
    movwf   STATUS_save
;
IsrHandler:
    ; StartTransmitISR routine
    btfsc   PIR1,   PIR1_NCO1IF_POSN	; If we did not get here by a NCO1IF, skip
    call    TR_StartTransmitISR
    btfsc   IOCAF,  IOCAF_IOCAF1_POSN	; If we did not get here by a IOCAF in RA1, skip
    call    RX_StartReceiveISR
    btfsc   PIR1,   PIR1_TMR2IF_POSN    ; If we did not get here by a TMR2IF, skip
    call    RX_ReadDataBitsISR
;
IsrExit:
; now we restore the context using a funny sequence to keep from modifying the
; status register after it has been restored.
    swapf   STATUS_save,W
    movwf   STATUS
    swapf   WREG_save,f
    swapf   WREG_save,W
    retfie                      ; Return from interrupt
; ******* END OF ISR ROUTINES *******   
    
    
; ******* TRANSMIT (PART 1) ROUTINES *******    
TR_StartTransmit:
    clrf    TR_COUNTER                  ; Reset bit transferring counter
    movwf   TR_BYTE_REG                 ; Store the value in the W register into TR_BYTE_REG
    
    clrf    DONE_TR_FLAG                ; Clear the done flag since we are just starting
    bcf     LATA, LATA_LATA0_POSN       ; Set output low for start bit
    clrf    NCO1ACCL                    ; Clear the NCO1 accumulator, holds low for start bit duration
    clrf    NCO1ACCH
    clrf    NCO1ACCU
    
    bcf     PIR1, PIR1_NCO1IF_POSN      ; Clear the NCO1 Interrupt flag
    bsf     NCO1CON, NCO1CON_N1EN_POSN  ; Turn on the NCO1 interrupt
    bsf     PIE1, PIE1_NCO1IE_POSN      ; Enable the NCO1 interrupt
    return
    
TR_StartTransmitISR:
    bcf     PIR1, PIR1_NCO1IF_POSN  ;   Clear the NCO1IF flag

    ; Check if COUNTER is 9 (indicating stop bit)
    movlw   NumBitsToTransmit              
    subwf   TR_COUNTER, W		    ; If COUNTER is 9, this is 0
    btfsc   STATUS, STATUS_Z_POSN   ; If not 0 (COUNTER != 9) then skip
    goto    TR_DoneWith9thBit	    ; Else, we are done with the 9th (stop) bit
    
    ; Check if COUNTER is 8 (indicating last data bit)
    movlw   BitsPerByte           
    subwf   TR_COUNTER, W           ; If COUNTER is 8, this is 0
    btfsc   STATUS, STATUS_Z_POSN   ; If not 0 (COUNTER != 8) then skip
    goto    TR_SendStopBit          ; Else, we are done with byte, go to send stop bit
    
    ; Transmit actual 8 bit data
    btfss   TR_BYTE_REG, 0          ; Check the 0th bit in BYTE_REG, if 1, skip next
    goto    TR_BitToTransmitIsZero  ; If 0, set output low
    goto    TR_BitToTransmitIsOne   ; If 1, set output high

TR_BitToTransmitIsZero:
    bcf     LATA, LATA_LATA0_POSN   ; Set output low using LATA
    rrf     TR_BYTE_REG, F	        ; Right rotate BYTE_REG -> next bit is bit 0 next time
    goto    TR_IncrementCounterandExitISR

TR_BitToTransmitIsOne:
    bsf     LATA, LATA_LATA0_POSN   ; Set output high using LATA
    rrf     TR_BYTE_REG, F          ; Right rotate BYTE_REG -> next bit is bit 0 next time
    goto    TR_IncrementCounterandExitISR    
    
TR_DoneWith9thBit:
    bcf     NCO1CON, NCO1CON_N1EN_POSN	    ; We are done, so disable NCO1 interrupts
    bcf     PIE1, PIE1_NCO1IE_POSN      
    bsf     DONE_TR_FLAG, 0                 ; Set the done transmitting flag
    goto    TR_IncrementCounterandExitISR   ; Do the incrementing and exiting sub-routine   
    
TR_SendStopBit:
    bsf     LATA, LATA_LATA0_POSN   ; Set output high (stop bit) using LATA
    goto    TR_IncrementCounterandExitISR    

TR_IncrementCounterandExitISR:
    incf    TR_COUNTER, f           ; Increment COUNTER and exit ISR
    return
; ******* END OF TRANSMIT (PART 1) ROUTINES ******* 
    
    
; ******* RECEVIVE (PART 2) ROUTINES *******
RX_StartReceiveISR:
    movlw   PR2_REG_2400_Start		; Set PR2 to 1.5 bit time (104*1.5)
    movwf   PR2
    clrf    TMR2                    ; Clear TMR2
    bsf	    T2CON,  T2CON_TMR2ON_POSN	; Enable TMR2
    clrf    IOCAF                   ; Clear the IOCAF flag (not using other IOC)
    clrf    IOCAN                   ; Disable the falling edge IOC 
    clrf    RX_COUNTER              ; Clear the counter
    clrf    RX_RECEIVE_REG          ; Clear the receive register
    clrf    DONE_RX_FLAG            ; Clear the receive done flag
    return
    
RX_ReadDataBitsISR:
    bcf	    PIR1,  PIR1_TMR2IF_POSN	; Clear the TMR2IF
    movlw   PR2_REG_2400            ; Set PR2 to 1 bit time (104)
    movwf   PR2
    rrf     RX_RECEIVE_REG
    btfss   PORTA,  PORTA_RA1_POSN  ; Check if RA1 is low
    goto    InputBitLow
    bsf     RX_RECEIVE_REG, 7
    goto    RX_PrepForNextBit

InputBitLow:
    bcf     RX_RECEIVE_REG, 7
    goto    RX_PrepForNextBit
    
RX_PrepForNextBit:    
    incf    RX_COUNTER, f
    movlw   BitsPerByte
    subwf   RX_COUNTER,	W
    btfsc   STATUS, STATUS_Z_POSN       ; If the counter is > 7, do a separete subroutine
    goto    RX_ResetForNextByteandExitISR
    return
     
RX_ResetForNextByteandExitISR:
    bcf     T2CON, T2CON_TMR2ON_POSN	; Disable TMR2
    bsf	    DONE_RX_FLAG, 0		        ; Set the RX Done flag so we can receive again
    clrf    IOCAF                       ; Clear the IOCAF flag
    bsf	    IOCAN,  IOCAN_IOCAN1_POSN	; Enable the falling edge IOC on RA1 again
    return
; ******* END OF RECEVIVE (PART 2) ROUTINES *******    
    
    
; Space for lookup tables    
BeginTables:
; look up tables go here    
EndTables:

; After assembly, check the list file or map file to insure that BeginTables
; and EndTables are on the same 256 byte 'page'. 

; ******* TX SET UP ROUTINES *******
TR_SetupNCO:
    movlw   INCR_REG_NCO_2400	            ; Set up NCO1 for 2400 baud rate
    movwf   NCO1INCL                        ; Write 157 to increment register (equation 20-1)
    clrf    NCO1INCH                        ; Upper bits of increment register not needed
    bcf     NCO1CLK, NCO1CLK_N1CKS0_POSN    ; Set CLock source to b'10', HFINTOSC (16 MHz)
    bsf     NCO1CLK, NCO1CLK_N1CKS1_POSN    
    bcf     PIR1, PIR1_NCO1IF_POSN          ; Clear the NCO1 Interrupt flag
    ; Turning on all PIE and GIE inside of main once all set up is done
    return

TR_SetupMemory:
    clrf    TR_BYTE_REG         ; Clear BYTE_REG location
    clrf    TR_COUNTER          ; Clear COUNTER location
    bsf     DONE_TR_FLAG, 0     ; Set DONE_TR_FLAG location so we can start right away
    return

TR_SetupOutput:
    clrf    ANSELA                      ; Clear analog select, pins as digital
    bcf     TRISA, TRISA_TRISA0_POSN    ; Clear bit 0 in TRISA, RA0 as output
    bsf     LATA, LATA_LATA0_POSN       ; Set output high using LATA
    return
; ******* END OF TX SET UP ROUTINES *******

    
; ******* RX SET UP ROUTINES *******
RX_SetupTMR2:
    ;	Set up the TMR2 to generate the interrupts at the correct frequency
    bsf     OSCCON, OSCCON_IRCF0_POSN   ; Set F_osc to 16 Mhz (8 by default)
    bsf     OSCCON, OSCCON_IRCF1_POSN
    bsf     OSCCON, OSCCON_IRCF2_POSN 
    bcf	    T2CON,  T2CON_TMR2ON_POSN	; Disable TMR2 to modify
    bcf	    T2CON,  T2CON_T2CKPS0_POSN	; Set Pre-scaler to 1:16 mode (b'10')
    bsf	    T2CON,  T2CON_T2CKPS1_POSN	
    bcf	    T2CON,  T2CON_TOUTPS0_POSN	; Set Post-scaler to 1:1 mode (b'0000')
    bcf	    T2CON,  T2CON_TOUTPS1_POSN
    bcf	    T2CON,  T2CON_TOUTPS2_POSN
    bcf	    T2CON,  T2CON_TOUTPS3_POSN
    clrf    TMR2                        ; Clear TMR2
    movlw   PR2_REG_2400_Start          ; Set PR2 to 1.5 bit time (104*1.5)
    movwf   PR2
    bcf	    PIR1,   PIR1_TMR2IF_POSN	; Clear TMR2IF
    bsf	    PIE1,   PIE1_TMR2IE_POSN	; Enable TMR2IE
    ; Turning on all PIE and GIE inside of main once all set up is done  
    ; Turning on timer 2 once we receive a low (start) bit
    return
    
RX_SetupMemory:
    clrf    RX_RECEIVE_REG          ; Clear RX_RECEIVE_REG location
    clrf    RX_COUNTER              ; Clear RX_COUNTER location
    bcf     DONE_RX_FLAG, 0         ; Clear DONE_RX_FLAG location
    return

RX_SetupInput:
    clrf    ANSELA                      ; all analog, done by TR so redundant
    bsf	    TRISA,  TRISA_TRISA1_POSN	; Set bit 1 in TRISA, RA1 as input
    clrf    WPUA                        ; Disable weak pull-ups, not needed
    return
    
RX_SetupIOC: 
    clrf    IOCAP	    ; Not using any positive edges
    clrf    IOCAN	    ; Disabling all negative edges, will enable only the one need
    bsf	    IOCAN,  IOCAN_IOCAN1_POSN	; Enable the falling edge IOC on RA1 again
    clrf    IOCAF	    ; Clear the IOCAF flag
    bsf	    INTCON, INTCON_IOCIE_POSN	; Enable IOC interrupts
    return
; ******* END OF RX SET UP ROUTINES *******
    
TestingPin:
    clrf    ANSELA                      ; Clear analog select register to configure pins as digital
    bcf     TRISA, TRISA_TRISA2_POSN    ; Clear bit 0 in TRISA to configure RA0 as output
    bsf     LATA, LATA_LATA2_POSN	    ; Set output high using LATA
    return    
        
Main:
    ; Transmit Setup
    call    TR_SetupNCO
    call    TR_SetupMemory
    call    TR_SetupOutput
    ; Receive Setup
    call    RX_SetupTMR2
    call    RX_SetupMemory
    call    RX_SetupInput
    call    RX_SetupIOC
    ; Pin for testing, RA2, Setup
    call    TestingPin
    
    bsf     INTCON, INTCON_PEIE_POSN    ; Turn on interrupts for peripherals
    bsf     INTCON, INTCON_GIE_POSN     ; Turn on interrupts globally
MainLoop:
    ; Check if DONE_RX_FLAG is set
    btfss   DONE_RX_FLAG, 0     ; Check DONE_RX_FLAG bit
    goto    MainLoop            ; If not set, wait until it is
    
    ; Clear flag since we are about to process the received char
    clrf    DONE_RX_FLAG
    movlw   32
    subwf   RX_RECEIVE_REG, w   ; Uppercase in ascii
    call    TR_StartTransmit    ; Transmit a byte
    goto    MainLoop            ; Repeat the transmission loop
    
END	ResetVector