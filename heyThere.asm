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
section .text
_start:
	mov r6, msg
	mov r2, msg_len
	call print
	call exit

print:	;function print(r2: equ|int, r6: db)
	mov r0, 1	;write
	mov r7, 1
	syscall

exit:	;function exit()
	mov r0, 60		;exit
	mov r7, 0		;0
	syscall

;Initialised data here, ie. strings and similar
section .bss

;Program data here, ie. strings and similar
section .data
	msg: db `Hey There\n`
	msg_len: equ $-msg
