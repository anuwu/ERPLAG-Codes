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

		SUB RSP, 6											; making space for declaration

		MOV AX, 4
		MOV [RBP - 6], AX										; store variable

		SUB RSP, 12											; making space for declaration


		MOV AX, 0
		MOV BX, [RBP - 6]
		CALL @dynamicDeclCheck										; checking dynamic array declaration limits


		PUSH BX												; saving register for malloc
		PUSH AX												; saving register for malloc
		CALL malloc
		MOV [RBP - 18], RAX
		POP AX
		MOV [RBP - 8], AX
		POP BX
		MOV [RBP - 10], BX

		SUB RSP, 6											; making space for declaration

		MOV AX, 1
		MOV [RBP - 2], AX										; store variable

		MOV AX, 2
		MOV [RBP - 4], AX										; store variable

		MOV AX, [RBP - 4]
		MOV [RBP - 2], AX										; store variable

		MOV RDI, [RBP - 18]
		MOV BX, 0
		MOV CX, [RBP - 4]
		MOV DX, [RBP - 10]
		CALL @boundCheck										; checking array index bound
		MOV AX, [RDI + RBX]

		MOV RDI, [RBP - 18]
		MOV BX, 0
		MOV CX, [RBP - 2]
		MOV DX, [RBP - 10]
		CALL @boundCheck										; checking array index bound
		MOV [RDI + RBX], AX										; store variable



		MOV RDI, [RBP - 18]
		CALL free

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
		MOV RDI, @boundPrint
		XOR RSI, RSI
		XOR RAX, RAX
		CALL printf
		MOV EDI, 0
		CALL exit

@declERROR:
		MOV RDI, @declPrint
		XOR RSI, RSI
		XOR RAX, RAX
		CALL printf
		MOV EDI, 0
		CALL exit

@declNegERROR:
		MOV RDI, @declNeg
		XOR RSI, RSI
		XOR RAX, RAX
		CALL printf
		MOV EDI, 0
		CALL exit

;--------------------------------------------------------------------------------------------------

section .data
		@boundPrint : db "RUNTIME ERROR : Array out of bounds" , 10, 0
		@declPrint : db "RUNTIME ERROR : Invalid order of bounds in dynamic array declaration" , 10, 0
		@declNeg : db "RUNTIME ERROR : Negative bound in dynamic array declaration" , 10, 0
