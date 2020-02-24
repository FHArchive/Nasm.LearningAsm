
;FredHappyface 2020
;
;Tell the assembler to use altreg so I can use r0 through r7 (this is personal preference)
;make _start public/ global (this is pretty much the equivalent of main in java or go)


%use altreg
global _start


;Program text here, ie. the bits to execute
section .text
_start:
	mov r1, 1
	mov r2, 2
	call swap
	cmp r1, 2
	jne swap_failed
	mov r0, 1		;write
	mov r7, 1		;stdout
	mov r6, success	;address of string
	mov r2, 11		;number of bytes
	syscall


swap_failed:
	mov r0, 60		;exit
	mov r7, 0		;0
	syscall


; Define the swap function. Takes r1 and r2 and swaps these
swap:
	mov r3, r1
	mov r1, r2
	mov r2, r3
	ret




;Program data here, ie. strings and similar
section .data
	success: db "Swap worked"
