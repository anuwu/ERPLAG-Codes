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


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -2
		CALL @getValuePrimitive

		MOV AX, [RBP - 2]
		PUSH AX
		CALL lol											; calling user function
		ADD RSP, 2

		MOV RSP, RBP
		POP RBP
		MOV RAX, 0x2000001
		XOR RDI, RDI
		syscall

;--------------------------------------------------------------------------------------------------

lol:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 2											; making space for declaration

		MOV BX, [RBP + 16]
		PUSH BX
		MOV AX, 2
		PUSH AX
		POP AX
		POP BX
		IMUL BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX										; store variable


	@WHILE1:
		MOV BX, 1
		PUSH BX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE2

		SUB RSP, 12											; making space for declaration

		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX

		MOV AX, [RBP + 16]
		MOV BX, [RBP - 2]
		CALL @dynamicDeclCheck										; checking dynamic array declaration limits


		PUSH BX												; saving register for malloc
		PUSH AX												; saving register for malloc
		SUB RSP, 12
		CALL _malloc
		ADD RSP, 12
		MOV [RBP - 14], RAX
		POP SI
		MOV [RBP - 4], SI
		POP DI
		MOV [RBP - 6], DI


		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX

		MOV RDI, [RBP - 14]
		CALL _free								; freeing local dynamic arrays


		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment

		ADD RSP, 12										; restoring to parent scope
		JMP @WHILE1

	@WHILE2:

		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

@dynamicDeclCheck:
		CMP AX, 0
		JGE .leftNotNeg
		CALL @declNegERROR

	.leftNotNeg:
		CMP BX, 0
		JGE .rightNotNeg
		CALL @declNegERROR

	.rightNotNeg:
		CMP BX, AX
		JGE .dynChecked
		CALL @declERROR

	.dynChecked:
		MOV DX, BX
		SUB DX, AX
		ADD DX, 1
		ADD DX, DX
		MOVSX RDI, DX

		ret

@declERROR:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		MOV RDI, @declPrint
		XOR RSI, RSI
		XOR RAX, RAX
		CALL _printf
		MOV RDI, 1
		CALL _exit

@declNegERROR:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		MOV RDI, @declNeg
		XOR RSI, RSI
		XOR RAX, RAX
		CALL _printf
		MOV RDI, 1
		CALL _exit

@getValuePrimitive:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		XOR RSI, RSI
		XOR RAX, RAX
		PUSH RBX
		PUSH RCX
		CALL _printf
		POP RCX
		POP RBX

		MOV RDI, @inputInt										; get_value
		MOV RSI, RSP
		SUB RSI, 16
		PUSH RBX
		PUSH RSI
		CALL _scanf
		POP RSI
		POP RBX
		MOV AX, [RSP - 16]
		MOV [RBP + RBX], AX

		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment

		ret

;--------------------------------------------------------------------------------------------------

section .data
		@declPrint : db "[1m[31mRuntime Error [0m[1m--> [0mInvalid order of bounds in dynamic array declaration. Halt!" , 10, 0
		@declNeg : db "[1m[31mRuntime Error [0m[1m--> [0mNegative bound in dynamic array declaration. Halt!" , 10, 0
		@inputIntPrompt : db "Enter an integer : " , 0
		@inputInt : db "%d", 0
