;;;;;;;;;;; Compiled for 64-bit macOS ;;;;;;;;;;;

extern _printf
extern _scanf
extern _malloc
extern _exit

global _main
section .text

_main:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 2											; making space for declaration

		MOV CX,1
		MOV [RBP - 2], CX
	@FOR1:
		MOV AX, 10
		CMP CX, AX
		JG @FOR2


		MOV CX, [RBP - 2]								; For loop increment
		INC CX
		MOV [RBP - 2],CX
		JMP @FOR1

	@FOR2:

		MOV RSP, RBP
		POP RBP
		MOV RAX, 0x2000001
		XOR RDI, RDI
		syscall

;--------------------------------------------------------------------------------------------------

;--------------------------------------------------------------------------------------------------
