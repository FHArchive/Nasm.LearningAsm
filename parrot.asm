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
;see https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
;for info on syscalls

%use altreg
global _start

;Program text here, ie. the bits to execute
section .text
_start:
	mov r0, 1		;write
	mov r7, 1		;stdout
	mov r6, msg_inp	;address of string
	mov r2, msg_inp_len		;number of bytes
	syscall

	mov r0, 0		;read
	mov r7, 0		;stdin
	mov r6, inp_buf	;address of input buffer
	syscall

	push r2

	mov r0, 1
	mov r7, 1
	mov r6, msg_usr	;"You entered: "
	mov r2, msg_usr_len
	syscall

	mov r0, 1
	mov r7, 1
	mov r6, inp_buf
	pop r2
	syscall

	call exit

exit:
	mov r0, 60		;exit
	mov r7, 0		;0
	syscall

;Uninitialised data here, ie. strings and similar
section .bss
	inp_buf resb 200
;Initialised data here, ie. strings and similar
section .data
	msg_inp: db "I am a parrot, input some text: "
	msg_inp_len: equ $-msg_inp

	msg_usr: db "You entered: "
	msg_usr_len: equ $-msg_usr
