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
		SUB RSP, 2											; making space for declaration

		MOV RDI, @inputIntPrompt								; get_value
		MOV RBX, -2
		CALL @getValuePrimitive

		MOV AX, [RBP - 2]
		PUSH AX
		MOV BX, 0
		PUSH BX
		POP BX
		POP AX
		CMP AX,BX
		SETL AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		MOV [RBP - 8], AX									; store variable


		MOV AX, [RBP - 8]									; loading switch variable

		CMP AX, 0
		JNE LABEL1											; true case
		JMP LABEL2											; false case

LABEL1:
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		NEG AX
		MOV [RBP - 4], AX									; store variable

		MOV BX, [RBP - 4]
		PUSH BX
		POP AX
		MOV [RBP - 2], AX									; store variable


		JMP LABEL3

LABEL2:
		MOV BX, [RBP - 2]
		PUSH BX
		POP AX
		MOV [RBP - 4], AX									; store variable


		JMP LABEL3

LABEL3:

		ADD RSP, 0											; restoring to parent scope
		MOV BX, 1
		PUSH BX
		POP AX
		MOV [RBP - 6], AX									; store variable


	WHILE4:
		MOV AX, [RBP - 4]
		PUSH AX
		MOV BX, 1
		PUSH BX
		POP BX
		POP AX
		CMP AX,BX
		SETG AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0								; Checking while loop condition
		JE WHILE5

		MOV BX, 2
		PUSH BX
		MOV AX, [RBP - 4]
		PUSH AX
		POP AX
		POP BX
		CWD
		IDIV BX
		PUSH AX
		POP AX
		MOV [RBP - 4], AX									; store variable

		MOV AX, [RBP - 6]
		PUSH AX
		MOV BX, 1
		PUSH BX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 6], AX									; store variable



		ADD RSP, 0										; restoring to parent scope
		JMP WHILE4

	WHILE5:
		SUB RSP, 12											; making space for declaration

		MOV AX, 0
		MOV BX, [RBP - 6]
		CALL @dynamicDeclCheck

		PUSH BX												; saving register for malloc
		PUSH AX												; saving register for malloc
		CALL malloc
		MOV [RBP - 20], RAX
		POP AX
		MOV [RBP - 10], AX
		POP BX
		MOV [RBP - 12], BX

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
		CALL @main
		ADD RSP, 16
		MOV RDI, [RBP - 20]
		MOV CX, 0
		MOV DX, [RBP - 12]
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @printIntegerArr


		MOV RDI, [RBP - 20]
		CALL free

		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

twosComplement:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 2											; making space for declaration
		MOV BX, [RBP + 24]
		PUSH BX
		POP AX
		MOV [RBP - 2], AX									; store variable

		SUB RSP, 12											; making space for declaration

		MOV AX, 0
		MOV BX, [RBP - 2]
		CALL @dynamicDeclCheck

		PUSH BX												; saving register for malloc
		PUSH AX												; saving register for malloc
		CALL malloc
		MOV [RBP - 14], RAX
		POP AX
		MOV [RBP - 4], AX
		POP BX
		MOV [RBP - 6], BX


	WHILE6:
		MOV RDI, [RBP + 16]
		MOV AX, 0
		MOV BX, [RBP - 2]
		MOV CX, [RBP + 24]
		CALL @boundCheck

		MOV AX, [RDI + RBX]
		PUSH AX
		MOV BX, 1
		PUSH BX
		POP BX
		POP AX
		CMP AX,BX
		SETNE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0								; Checking while loop condition
		JE WHILE7

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX									; store variable



		ADD RSP, 0										; restoring to parent scope
		JMP WHILE6

	WHILE7:
		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX									; store variable


	WHILE8:
		MOV AX, [RBP - 2]
		PUSH AX
		MOV BX, 0
		PUSH BX
		POP BX
		POP AX
		CMP AX,BX
		SETGE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0								; Checking while loop condition
		JE WHILE9

		MOV BX, 1
		PUSH BX
		MOV RDI, [RBP + 16]
		MOV AX, 0
		MOV BX, [RBP - 2]
		MOV CX, [RBP + 24]
		CALL @boundCheck

		MOV AX, [RDI + RBX]
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		MOV RDI, [RBP + 16]
		MOV AX, 0
		MOV BX, [RBP - 2]
		MOV CX, [RBP + 24]
		CALL @boundCheck

		POP AX
		NEG AX
		MOV [RDI + RBX], AX									; store variable

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX									; store variable



		ADD RSP, 0										; restoring to parent scope
		JMP WHILE8

	WHILE9:

		MOV RDI, [RBP - 14]
		CALL free

		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

@main:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 2											; making space for declaration
		MOV BX, 0
		PUSH BX
		MOV RDI, [RBP + 20]
		MOV AX, 0
		MOV BX, 0
		MOV CX, [RBP + 28]
		CALL @boundCheck

		POP AX
		MOV [RDI + RBX], AX									; store variable

		MOV BX, 1
		PUSH BX
		POP AX
		MOV [RBP - 2], AX									; store variable


	WHILE10:
		MOV AX, [RBP + 16]
		PUSH AX
		MOV BX, 0
		PUSH BX
		POP BX
		POP AX
		CMP AX,BX
		SETNE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0								; Checking while loop condition
		JE WHILE11

		MOV BX, 2
		PUSH BX
		MOV BX, 2
		PUSH BX
		MOV AX, [RBP + 16]
		PUSH AX
		POP AX
		POP BX
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
		MOV RDI, [RBP + 20]
		MOV AX, 0
		MOV BX, [RBP - 2]
		MOV CX, [RBP + 28]
		CALL @boundCheck

		POP AX
		MOV [RDI + RBX], AX									; store variable

		MOV BX, 2
		PUSH BX
		MOV AX, [RBP + 16]
		PUSH AX
		POP AX
		POP BX
		CWD
		IDIV BX
		PUSH AX
		POP AX
		MOV [RBP + 16], AX									; store variable

		MOV AX, [RBP - 2]
		PUSH AX
		MOV BX, 1
		PUSH BX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX									; store variable



		ADD RSP, 0										; restoring to parent scope
		JMP WHILE10

	WHILE11:
		MOV AX, [RBP + 30]
		PUSH AX
		MOV BX, [RBP + 28]
		PUSH BX
		MOV RAX, [RBP + 20]
		PUSH RAX
		CALL binRev
		ADD RSP, 12

		MOV AX, [RBP + 18]									; loading switch variable

		CMP AX, 0
		JNE LABEL12											; true case
		JMP LABEL13											; false case

LABEL12:
		MOV AX, [RBP + 30]
		PUSH AX
		MOV BX, [RBP + 28]
		PUSH BX
		MOV RAX, [RBP + 20]
		PUSH RAX
		CALL twosComplement
		ADD RSP, 12

		JMP LABEL14

LABEL13:

		JMP LABEL14

LABEL14:

		ADD RSP, 0											; restoring to parent scope


		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

binRev:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 8											; making space for declaration
		MOV AX, [RBP + 26]
		PUSH AX
		MOV BX, 1
		PUSH BX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX									; store variable

		MOV BX, [RBP + 24]
		PUSH BX
		POP AX
		MOV [RBP - 4], AX									; store variable


	WHILE15:
		MOV AX, [RBP - 4]
		PUSH AX
		MOV BX, [RBP - 2]
		PUSH BX
		POP BX
		POP AX
		CMP AX,BX
		SETG AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0								; Checking while loop condition
		JE WHILE16

		MOV RDI, [RBP + 16]
		MOV AX, [RBP + 26]
		MOV BX, [RBP - 2]
		MOV CX, [RBP + 24]
		CALL @boundCheck

		MOV BX, [RDI + RBX]
		PUSH BX
		POP AX
		MOV [RBP - 6], AX									; store variable

		MOV RDI, [RBP + 16]
		MOV AX, [RBP + 26]
		MOV BX, [RBP - 4]
		MOV CX, [RBP + 24]
		CALL @boundCheck

		MOV BX, [RDI + RBX]
		PUSH BX
		POP AX
		MOV [RBP - 8], AX									; store variable

		SUB RSP, 4
		MOV AX, [RBP - 8]
		PUSH AX
		MOV AX, [RBP - 6]
		PUSH AX
		CALL exch
		ADD RSP, 4
		POP AX
		MOV [RBP - 6], AX
		POP AX
		MOV [RBP - 8], AX

		MOV BX, [RBP - 6]
		PUSH BX
		MOV RDI, [RBP + 16]
		MOV AX, [RBP + 26]
		MOV BX, [RBP - 2]
		MOV CX, [RBP + 24]
		CALL @boundCheck

		POP AX
		MOV [RDI + RBX], AX									; store variable

		MOV BX, [RBP - 8]
		PUSH BX
		MOV RDI, [RBP + 16]
		MOV AX, [RBP + 26]
		MOV BX, [RBP - 4]
		MOV CX, [RBP + 24]
		CALL @boundCheck

		POP AX
		MOV [RDI + RBX], AX									; store variable

		MOV AX, [RBP - 2]
		PUSH AX
		MOV BX, 1
		PUSH BX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 2], AX									; store variable

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 4]
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 4], AX									; store variable



		ADD RSP, 0										; restoring to parent scope
		JMP WHILE15

	WHILE16:


		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

exch:
		PUSH RBP
		MOV RBP, RSP

		MOV BX, [RBP + 18]
		PUSH BX
		POP AX
		MOV [RBP + 20], AX									; store variable

		MOV BX, [RBP + 16]
		PUSH BX
		POP AX
		MOV [RBP + 22], AX									; store variable



		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

;--------------------------------------------------------------------------------------------------

@boundCheck:
		CMP BX, AX
		JGE .leftLim
		CALL @boundERROR

	.leftLim:
		CMP CX, BX
		JGE .rightLim
		CALL @boundERROR

	.rightLim:
		SUB BX, AX
		ADD BX, BX
		MOVSX RBX, BX

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

@getValuePrimitive:
		XOR RSI, RSI
		XOR RAX, RAX
		PUSH RBX
		CALL printf
		POP RBX

		MOV RAX, RSP
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		MOV RDI, @inputInt									; get_value
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
		ADD RSP, RAX

		ret

@printIntegerArr:
		PUSH RDI
		MOV RDI, @printFormatArray
		XOR RSI, RSI
		XOR RAX, RAX
		PUSH DX
		CALL printf
		POP DX
		POP RDI

		MOV CX, 0

	.printArr:								; printing array
		PUSH RDI
		MOVSX RBX, CX
		MOV SI, [RDI + RBX]
		MOV RDI, @printInt
		MOVSX RSI, SI
		XOR RAX, RAX
		PUSH CX
		PUSH DX
		CALL printf
		POP DX
		POP CX
		POP RDI

		ADD CX, 2
		CMP CX, DX
		JNE .printArr

		MOV RDI, @printNewLine
		XOR RSI, RSI
		XOR RAX, RAX
		CALL printf

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
		@printFormatArray : db "Output : " , 0
		@printInt : db "%d ", 0
		@printNewLine : db 10, 0
		@inputIntPrompt : db "Enter an integer : " , 0
		@inputInt : db "%d", 0
