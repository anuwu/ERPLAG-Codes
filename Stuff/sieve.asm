;;;;;;;;;;; Compiled for 64-bit Linux ;;;;;;;;;;;

extern printf
extern scanf
extern malloc
extern free
extern exit

global main
section .text

main:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 2											; making space for declaration


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -2
		CALL @getValuePrimitive

		MOV AX, [RBP - 2]
		PUSH AX
		CALL sieve											; calling user function
		ADD RSP, 2

		MOV RSP, RBP
		POP RBP
		MOV RAX, 60
		XOR RDI, RDI
		syscall

;--------------------------------------------------------------------------------------------------

sieve:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 12											; making space for declaration

		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX

		MOV AX, 2
		MOV BX, [RBP + 16]
		CALL @dynamicDeclCheck										; checking dynamic array declaration limits


		PUSH BX												; saving register for malloc
		PUSH AX												; saving register for malloc
		SUB RSP, 12
		CALL malloc
		ADD RSP, 12
		MOV [RBP - 12], RAX
		POP SI
		MOV [RBP - 2], SI
		POP DI
		MOV [RBP - 4], DI


		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment
		SUB RSP, 2											; making space for declaration

		SUB RSP, 8											; making space for declaration

		MOV AX, 2
		MOV [RBP - 16], AX										; store variable


	@WHILE1:
		MOV BX, [RBP + 16]
		PUSH BX
		MOV AX, [RBP - 16]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETLE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE2

		MOV AX, 0
		MOV RDI, [RBP - 12]
		MOV BX, 2
		MOV CX, [RBP - 16]
		MOV DX, [RBP - 4]
		CALL @boundCheck										; checking array index bound
		MOV [RDI + RBX], AX										; store variable

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 16]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 16], AX										; store variable

		JMP @WHILE1

	@WHILE2:
		MOV AX, 0
		MOV [RBP - 22], AX										; store variable

		MOV AX, 2
		MOV [RBP - 18], AX										; store variable

		MOV BX, [RBP - 18]
		PUSH BX
		MOV AX, [RBP - 18]
		PUSH AX
		POP AX
		POP BX
		IMUL BX
		PUSH AX
		POP AX
		MOV [RBP - 20], AX										; store variable


	@WHILE3:
		MOV BX, [RBP + 16]
		PUSH BX
		MOV AX, [RBP - 20]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETLE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE4


	@WHILE5:
		MOV BX, [RBP + 16]
		PUSH BX
		MOV AX, [RBP - 20]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETLE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE6

		MOV RDI, [RBP - 12]
		MOV BX, 2
		MOV CX, [RBP - 20]
		MOV DX, [RBP - 4]
		CALL @boundCheck										; checking array index bound
		MOV AX, [RDI + RBX]

		MOV [RBP - 14], AX										; store variable


		MOV AX, [RBP - 14]										; loading switch variable

		CMP AX, 0
		JE @SWITCH1											; false case
		JMP @SWITCH2											; true case

@SWITCH1:
		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 22]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 22], AX										; store variable


		JMP @SWITCH3

@SWITCH2:

		JMP @SWITCH3

@SWITCH3:
		MOV AX, 1
		MOV RDI, [RBP - 12]
		MOV BX, 2
		MOV CX, [RBP - 20]
		MOV DX, [RBP - 4]
		CALL @boundCheck										; checking array index bound
		MOV [RDI + RBX], AX										; store variable

		MOV BX, [RBP - 18]
		PUSH BX
		MOV AX, [RBP - 20]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 20], AX										; store variable

		JMP @WHILE5

	@WHILE6:
		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 18]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 18], AX										; store variable


	@WHILE7:
		MOV RDI, [RBP - 12]
		MOV BX, 2
		MOV CX, [RBP - 18]
		MOV DX, [RBP - 4]
		CALL @boundCheck										; checking array index bound
		MOV BX, [RDI + RBX]

		PUSH BX
		MOV BX, [RBP + 16]
		PUSH BX
		MOV AX, [RBP - 18]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETLE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		POP BX
		AND AX, BX
		PUSH AX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE8

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 18]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 18], AX										; store variable

		JMP @WHILE7

	@WHILE8:
		MOV BX, [RBP - 18]
		PUSH BX
		MOV AX, [RBP - 18]
		PUSH AX
		POP AX
		POP BX
		IMUL BX
		PUSH AX
		POP AX
		MOV [RBP - 20], AX										; store variable

		JMP @WHILE3

	@WHILE4:
		MOV BX, [RBP - 22]
		PUSH BX
		MOV BX, 1
		PUSH BX
		MOV AX, [RBP + 16]
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 22], AX										; store variable

		SUB RSP, 2											; making space for declaration

		SUB RSP, 12											; making space for declaration

		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX

		MOV AX, 1
		MOV BX, [RBP - 22]
		CALL @dynamicDeclCheck										; checking dynamic array declaration limits


		PUSH BX												; saving register for malloc
		PUSH AX												; saving register for malloc
		SUB RSP, 12
		CALL malloc
		ADD RSP, 12
		MOV [RBP - 36], RAX
		POP SI
		MOV [RBP - 26], SI
		POP DI
		MOV [RBP - 28], DI


		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment
		MOV AX, 1
		MOV [RBP - 24], AX										; store variable

		MOV AX, 2
		MOV [RBP - 16], AX										; store variable


	@WHILE9:
		MOV BX, [RBP + 16]
		PUSH BX
		MOV AX, [RBP - 16]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETLE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE @WHILE10

		MOV RDI, [RBP - 12]
		MOV BX, 2
		MOV CX, [RBP - 16]
		MOV DX, [RBP - 4]
		CALL @boundCheck										; checking array index bound
		MOV AX, [RDI + RBX]

		MOV [RBP - 14], AX										; store variable


		MOV AX, [RBP - 14]										; loading switch variable

		CMP AX, 0
		JE @SWITCH4											; false case
		JMP @SWITCH5											; true case

@SWITCH4:
		MOV AX, [RBP - 16]
		MOV RDI, [RBP - 36]
		MOV BX, 1
		MOV CX, [RBP - 24]
		MOV DX, [RBP - 28]
		CALL @boundCheck										; checking array index bound
		MOV [RDI + RBX], AX										; store variable

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 24]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 24], AX										; store variable


		JMP @SWITCH6

@SWITCH5:

		JMP @SWITCH6

@SWITCH6:
		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 16]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 16], AX										; store variable

		JMP @WHILE9

	@WHILE10:
		MOV RDI, [RBP - 36]
		MOV CX, 1
		MOV DX, [RBP - 28]
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @printIntegerArr

		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX

		MOV RDI, [RBP - 36]
		CALL free								; freeing local dynamic arrays


		MOV RDI, [RBP - 12]
		CALL free								; freeing local dynamic arrays


		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment

		MOV RSP, RBP
		POP RBP
		ret

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
		CALL printf
		MOV RDI, 1
		CALL exit

@declERROR:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		MOV RDI, @declPrint
		XOR RSI, RSI
		XOR RAX, RAX
		CALL printf
		MOV RDI, 1
		CALL exit

@declNegERROR:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		MOV RDI, @declNeg
		XOR RSI, RSI
		XOR RAX, RAX
		CALL printf
		MOV RDI, 1
		CALL exit

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
		CALL printf
		POP RCX
		POP RBX

		MOV RDI, @inputInt										; get_value
		MOV RSI, RSP
		SUB RSI, 16
		PUSH RBX
		PUSH RSI
		CALL scanf
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
		CALL printf
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
		CALL printf
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
		CALL printf

		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment

		ret

;--------------------------------------------------------------------------------------------------

section .data
		@boundPrint : db "[1m[31mRuntime Error [0m[1m--> [0mArray out of bounds. Halt!" , 10, 0
		@declPrint : db "[1m[31mRuntime Error [0m[1m--> [0mInvalid order of bounds in dynamic array declaration. Halt!" , 10, 0
		@declNeg : db "[1m[31mRuntime Error [0m[1m--> [0mNegative bound in dynamic array declaration. Halt!" , 10, 0
		@printFormatArray : db "Output : " , 0
		@printInt : db "%d ", 0
		@printNewLine : db 10, 0
		@inputIntPrompt : db "Enter an integer : " , 0
		@inputInt : db "%d", 0
