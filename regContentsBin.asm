;FredHappyface 2020
;
;Tell the assembler to use altreg so I can use r0 through r7 (this is personal preference)
;make _start public/ global (this is pretty much the equivalent of main in java or go)
;|r0|r1|r2|r3|r4|r5|r6|r7|r8-r15|
;|ax|cx|dx|bx|sp|bp|si|di|      |
;
;size  |64|32|16| 8|
;altreg|  | d| w| b|[append]
;   reg| r| e|  |--|[prepend]

%use altreg
global _start

;Program text here, ie. the bits to execute
;Test the printReg function. Should print:
;0b1010
;0b1100100
;0b1111101000
section .text
_start:
	mov r8, 10
	call printReg
	mov r8, 100
	call printReg
	mov r8, 1000
	call printReg
	call exit


;r0 FREE: functions are register safe,
;r1 RESERVED: used for shift,
;r2 FREE: printChar is register safe,
;r3 FREE,
;r4 RESERVED: stack pointer - using this very much breaks things,
;r5 FREE: stack frame pointer - probably shouldn't use,
;r6 RESERVED: passed into print and printChar,
;r7 FREE: functions are register safe,
;r8-r15 FREE
;register_val = r8
;flag_start = r3
;shift = r9
;bit = r5
;
;Used by subroutines
;print, printChar = r6
printReg:	;function printReg(r8: int){
	mov r6, msg
	add r6, 3
	mov r2, 2
	call print


	mov r3, 0
	mov r9, 63
loopBit:	;for(int shift = 63; shift >= 0 ; shift--)
	mov r5, r8	;int bit = register_val >> shift & 1
	mov r1b, r9b
	shr r5, r1b
	and r5, 1
	cmp r5, 1
	jne ifNotBit	;if(bit){flag_start = 1;}
	mov r3, 1
ifNotBit:
	cmp r3, 1
	jne ifNotFlagStart	;if(flag_start){printf("%d", bit);}
	mov r6, msg
	add r6, r5
	call printChar
ifNotFlagStart:
	sub r9, 1
	cmp r9, 0
	jge loopBit
	mov r6, msg
	add r6, 2
	call printChar
	ret


printChar:	;function print(r6: db) register 'safe'
	push r2
	mov r2, 1
	call print
	pop r2
	ret

print:	;function print(r2: equ|int, r6: db) register 'safe'
	push r0
	push r7
	mov r0, 1	;write
	mov r7, 1	;stdout
	syscall
	pop r7
	pop r0
	ret

exit:	;function exit()
	mov r0, 60	;exit
	mov r7, 0	;0
	syscall


;Initialised data here, ie. strings and similar
section .bss

;Program data here, ie. strings and similar
section .data
	msg: db `01\n0b`
