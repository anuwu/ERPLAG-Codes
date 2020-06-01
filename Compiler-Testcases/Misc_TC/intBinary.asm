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

		SUB RSP, 6											; making space for declaration

		SUB RSP, 2											; making space for declaration

		MOV AX, 1
		MOV [RBP - 8], AX										; store variable


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -2
		CALL @getValuePrimitive

		MOV BX, 0
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETL AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		MOV [RBP - 8], AX										; store variable


		MOV AX, [RBP - 8]										; loading switch variable

		CMP AX, 0
		JNE @SWITCH1											; true case
		JMP @SWITCH2											; false case

@SWITCH1:
		MOV AX, [RBP - 2]
		NEG AX
		MOV [RBP - 4], AX										; store variable

		MOV AX, [RBP - 4]
		MOV [RBP - 2], AX										; store variable


		JMP @SWITCH3

@SWITCH2:
		MOV AX, [RBP - 2]
		MOV [RBP - 4], AX										; store variable


		JMP @SWITCH3

@SWITCH3:
		MOV AX, 1
		MOV [RBP - 6], AX										; store variable


	@WHILE1:
		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 4]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETG AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE2

		MOV BX, 2
		PUSH BX
		MOV AX, [RBP - 4]
		PUSH AX
		POP AX
		POP BX
		CMP BX, 0
		JNE @DIV_ZERO1
		CALL @divZeroERROR

	@DIV_ZERO1:
		CWD
		IDIV BX
		PUSH AX
		POP AX
		MOV [RBP - 4], AX										; store variable

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 6]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 6], AX										; store variable

		JMP @WHILE1

	@WHILE2:
		SUB RSP, 12											; making space for declaration

		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX

		MOV AX, 0
		MOV BX, [RBP - 6]
		CALL @dynamicDeclCheck										; checking dynamic array declaration limits


		PUSH BX												; saving register for malloc
		PUSH AX												; saving register for malloc
		SUB RSP, 12
		CALL _malloc
		ADD RSP, 12
		MOV [RBP - 20], RAX
		POP SI
		MOV [RBP - 10], SI
		POP DI
		MOV [RBP - 12], DI


		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment
		MOV AX, [RBP - 10]
		PUSH AX
		MOV BX, [RBP - 12]
		PUSH BX
		MOV RAX, [RBP - 20]
		PUSH RAX
		MOV AX, [RBP - 8]
		PUSH AX
		MOV AX, [RBP - 2]
		PUSH AX
		CALL @main											; calling user function
		ADD RSP, 16
		MOV RDI, [RBP - 20]
		MOV CX, 0
		MOV DX, [RBP - 12]
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @printIntegerArr


		MOV RSP, RBP
		POP RBP
		MOV RAX, 0x2000001
		XOR RDI, RDI
		syscall

;--------------------------------------------------------------------------------------------------

twosComplement:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 2											; making space for declaration

		MOV AX, [RBP + 24]
		MOV [RBP - 2], AX										; store variable


	@WHILE3:
		MOV BX, 1
		PUSH BX
		MOV RDI, [RBP + 16]
		MOV BX, 0
		MOV CX, [RBP - 2]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV AX, [RDI + RBX]

		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETNE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE4

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX										; store variable

		JMP @WHILE3

	@WHILE4:
		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX										; store variable


	@WHILE5:
		MOV BX, 0
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETGE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE6

		MOV BX, 1
		PUSH BX
		MOV RDI, [RBP + 16]
		MOV BX, 0
		MOV CX, [RBP - 2]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV AX, [RDI + RBX]

		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		NEG AX
		MOV RDI, [RBP + 16]
		MOV BX, 0
		MOV CX, [RBP - 2]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV [RDI + RBX], AX										; store variable

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX										; store variable

		JMP @WHILE5

	@WHILE6:

		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

@main:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 2											; making space for declaration

		MOV AX, 0
		MOV RDI, [RBP + 20]
		MOV BX, 0
		MOV CX, 0
		MOV DX, [RBP + 28]
		CALL @boundCheck										; checking array index bound
		MOV [RDI + RBX], AX										; store variable

		MOV RDI, [RBP + 20]
		MOV BX, 0
		MOV CX, 0
		MOV DX, [RBP + 28]
		CALL @boundCheck										; checking array index bound
		MOV AX, [RDI + RBX]

		MOV RDI, [RBP + 20]
		MOV BX, 0
		MOV CX, 1
		MOV DX, [RBP + 28]
		CALL @boundCheck										; checking array index bound
		MOV [RDI + RBX], AX										; store variable

		MOV AX, 1
		MOV [RBP - 2], AX										; store variable


	@WHILE7:
		MOV BX, 0
		PUSH BX
		MOV AX, [RBP + 16]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETNE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE8

		MOV BX, 2
		PUSH BX
		MOV BX, 2
		PUSH BX
		MOV AX, [RBP + 16]
		PUSH AX
		POP AX
		POP BX
		CMP BX, 0
		JNE @DIV_ZERO2
		CALL @divZeroERROR

	@DIV_ZERO2:
		CWD
		IDIV BX
		PUSH AX
		POP AX
		POP BX
		IMUL BX
		PUSH AX
		MOV AX, [RBP + 16]
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		MOV RDI, [RBP + 20]
		MOV BX, 0
		MOV CX, [RBP - 2]
		MOV DX, [RBP + 28]
		CALL @boundCheck										; checking array index bound
		MOV [RDI + RBX], AX										; store variable

		MOV BX, 2
		PUSH BX
		MOV AX, [RBP + 16]
		PUSH AX
		POP AX
		POP BX
		CMP BX, 0
		JNE @DIV_ZERO3
		CALL @divZeroERROR

	@DIV_ZERO3:
		CWD
		IDIV BX
		PUSH AX
		POP AX
		MOV [RBP + 16], AX										; store variable

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX										; store variable

		JMP @WHILE7

	@WHILE8:
		MOV AX, [RBP + 30]
		PUSH AX
		MOV BX, [RBP + 28]
		PUSH BX
		MOV RAX, [RBP + 20]
		PUSH RAX
		CALL binRev											; calling user function
		ADD RSP, 12

		MOV AX, [RBP + 18]										; loading switch variable

		CMP AX, 0
		JNE @SWITCH4											; true case
		JMP @SWITCH5											; false case

@SWITCH4:
		MOV AX, [RBP + 30]
		PUSH AX
		MOV BX, [RBP + 28]
		PUSH BX
		MOV RAX, [RBP + 20]
		PUSH RAX
		CALL twosComplement											; calling user function
		ADD RSP, 12

		JMP @SWITCH6

@SWITCH5:

		JMP @SWITCH6

@SWITCH6:

		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

binRev:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 8											; making space for declaration

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP + 26]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX										; store variable

		MOV AX, [RBP + 24]
		MOV [RBP - 4], AX										; store variable


	@WHILE9:
		MOV BX, [RBP - 2]
		PUSH BX
		MOV AX, [RBP - 4]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETG AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE10

		MOV RDI, [RBP + 16]
		MOV BX, [RBP + 26]
		MOV CX, [RBP - 2]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV AX, [RDI + RBX]

		MOV [RBP - 6], AX										; store variable

		MOV RDI, [RBP + 16]
		MOV BX, [RBP + 26]
		MOV CX, [RBP - 4]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV AX, [RDI + RBX]

		MOV [RBP - 8], AX										; store variable

		SUB RSP, 4
		MOV AX, [RBP - 8]
		PUSH AX
		MOV AX, [RBP - 6]
		PUSH AX
		CALL exch											; calling user function
		ADD RSP, 4
		POP AX
		MOV [RBP - 6], AX
		POP AX
		MOV [RBP - 8], AX

		MOV AX, [RBP - 6]
		MOV RDI, [RBP + 16]
		MOV BX, [RBP + 26]
		MOV CX, [RBP - 2]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV [RDI + RBX], AX										; store variable

		MOV AX, [RBP - 8]
		MOV RDI, [RBP + 16]
		MOV BX, [RBP + 26]
		MOV CX, [RBP - 4]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV [RDI + RBX], AX										; store variable

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX										; store variable

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 4]
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 4], AX										; store variable

		JMP @WHILE9

	@WHILE10:

		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

exch:
		PUSH RBP
		MOV RBP, RSP

		MOV AX, [RBP + 18]
		MOV [RBP + 20], AX										; store variable

		MOV AX, [RBP + 16]
		MOV [RBP + 22], AX										; store variable


		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

;--------------------------------------------------------------------------------------------------

@boundCheck:
		CMP CX, BX
		JGE .leftLim
		CALL @boundERROR

	.leftLim:
		CMP DX, CX
		JGE .rightLim
		CALL @boundERROR

	.rightLim:
		SUB CX, BX
		ADD CX, CX
		MOVSX RBX, CX

		ret

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

@boundERROR:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		MOV RDI, @boundPrint
		XOR RSI, RSI
		XOR RAX, RAX
		CALL _printf
		MOV RDI, 1
		CALL _exit

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

@divZeroERROR:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		MOV RDI, @divZero
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

@printIntegerArr:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		PUSH RDI
		MOV RDI, @printFormatArray
		XOR RSI, RSI
		XOR RAX, RAX
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		CALL _printf
		POP DX
		POP CX
		POP BX
		POP AX
		POP RDI

		MOV CX, 0

	.printArr:								; printing array
		PUSH RDI
		MOVSX RBX, CX
		MOV SI, [RDI + RBX]
		MOV RDI, @printInt
		MOVSX RSI, SI
		XOR RAX, RAX
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		CALL _printf
		POP DX
		POP CX
		POP BX
		POP AX
		POP RDI

		ADD CX, 2
		CMP CX, DX
		JNE .printArr

		MOV RDI, @printNewLine
		XOR RSI, RSI
		XOR RAX, RAX
		CALL _printf

		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment

		ret

;--------------------------------------------------------------------------------------------------

section .data
		@boundPrint : db "[1m[31mRuntime Error [0m[1m--> [0mArray out of bounds. Halt!" , 10, 0
		@declPrint : db "[1m[31mRuntime Error [0m[1m--> [0mInvalid order of bounds in dynamic array declaration. Halt!" , 10, 0
		@declNeg : db "[1m[31mRuntime Error [0m[1m--> [0mNegative bound in dynamic array declaration. Halt!" , 10, 0
		@divZero: db "[1m[31mRuntime Error [0m[1m--> [0mDivision by zero detected. Halt!" , 10, 0
		@printFormatArray : db "Output : " , 0
		@printInt : db "%d ", 0
		@printNewLine : db 10, 0
		@inputIntPrompt : db "Enter an integer : " , 0
		@inputInt : db "%d", 0
