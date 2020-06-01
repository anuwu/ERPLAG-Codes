;;;;;;;;;;; Compiled for 64-bit macOS ;;;;;;;;;;;

extern _printf
extern _scanf
extern _malloc
extern _free
extern _exit

global _main
section .text

_main:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 2											; making space for declaration

		SUB RSP, 2											; making space for declaration

		MOV AX, 0
		MOV [RBP - 2], AX										; store variable


	@WHILE1:
		MOV BX, 1
		PUSH BX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE2

		JMP @WHILE1

	@WHILE2:
		MOV SI, [RBP - 2]
		CALL @printBoolean


		MOV RSP, RBP
		POP RBP
		MOV RAX, 0x2000001
		XOR RDI, RDI
		syscall

;--------------------------------------------------------------------------------------------------

@printBoolean:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		CMP SI, 0
		JE .boolFalse
		MOV RDI, @printTrue
		JMP .boolPrint

	.boolFalse:
		MOV RDI, @printFalse

	.boolPrint:
		XOR RSI, RSI
		XOR RAX, RAX
		CALL _printf

		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment

		ret

;--------------------------------------------------------------------------------------------------

section .data
		@printTrue : db "Output : true" , 10, 0
		@printFalse : db "Output : false" , 10, 0
