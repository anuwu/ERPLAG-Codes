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


		MOV AX, [RBP - 2]										; loading switch variable

		CMP AX, 1											; switch case
		JE @SWITCH1

		CMP AX, 2											; switch case
		JE @SWITCH2

		CMP AX, 3											; switch case
		JE @SWITCH3

		JMP @SWITCH4											; default case

@SWITCH1:

		JMP @SWITCH5

@SWITCH2:

		JMP @SWITCH5

@SWITCH3:

		JMP @SWITCH5

@SWITCH4:

		JMP @SWITCH5

@SWITCH5:

		MOV RSP, RBP
		POP RBP
		MOV RAX, 0x2000001
		XOR RDI, RDI
		syscall

;--------------------------------------------------------------------------------------------------

;--------------------------------------------------------------------------------------------------
