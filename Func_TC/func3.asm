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


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -2
		CALL @getValuePrimitive


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -4
		CALL @getValuePrimitive

		SUB RSP, 12											; making space for declaration


		MOV AX, [RBP - 2]
		MOV BX, [RBP - 4]
		CALL @dynamicDeclCheck										; checking dynamic array declaration limits


		PUSH BX												; saving register for malloc
		PUSH AX												; saving register for malloc
		CALL malloc
		MOV [RBP - 18], RAX
		POP AX
		MOV [RBP - 8], AX
		POP BX
		MOV [RBP - 10], BX

		SUB RSP, 4											; making space for declaration

		MOV RDI, @inputIntArrPrompt
		MOV BX, [RBP - 8]
		MOV CX, [RBP - 10]
		CALL @printGetArrPrompt

		MOV RDI, [RBP - 18]
		MOV DX, CX
		SUB DX, BX
		ADD DX, 1
		ADD DX, DX
		MOVSX RDX, DX
		CALL @getArr


		MOV RDI, @inputBoolPrompt									; get_value
		MOV RBX, -20
		CALL @getValuePrimitive

		SUB RSP, 4
		MOV AX, [RBP - 20]
		PUSH AX
		MOV AX, [RBP - 8]
		PUSH AX
		MOV BX, [RBP - 10]
		PUSH BX
		MOV RAX, [RBP - 18]
		PUSH RAX
		CALL isSortAndSum											; calling user function
		ADD RSP, 14
		POP AX
		MOV [RBP - 22], AX
		POP AX
		MOV [RBP - 6], AX

		MOV SI, [RBP - 6]
		CALL @printInteger

		MOV SI, [RBP - 22]
		CALL @printBoolean


		MOV RDI, [RBP - 18]
		CALL free

		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

isSortAndSum:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 4											; making space for declaration

		SUB RSP, 2											; making space for declaration

		MOV AX, 1
		MOV [RBP + 30], AX										; store variable

		MOV RDI, [RBP + 16]
		MOV BX, [RBP + 26]
		MOV CX, [RBP + 26]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV AX, [RDI + RBX]

		MOV [RBP - 4], AX										; store variable

		MOV RDI, [RBP + 16]
		MOV BX, [RBP + 26]
		MOV CX, [RBP + 26]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV AX, [RDI + RBX]

		MOV [RBP + 32], AX										; store variable

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


	WHILE1:
		MOV BX, [RBP + 24]
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETLE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		CMP AX, 0											; checking while loop condition
		JE WHILE2

		MOV RDI, [RBP + 16]
		MOV BX, [RBP + 26]
		MOV CX, [RBP - 2]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV BX, [RDI + RBX]

		PUSH BX
		MOV AX, [RBP + 32]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP + 32], AX										; store variable


		MOV AX, [RBP + 30]										; loading switch variable

		CMP AX, 0
		JNE LABEL3											; true case
		JMP LABEL4											; false case

LABEL3:

		MOV AX, [RBP + 28]										; loading switch variable

		CMP AX, 0
		JNE LABEL6											; true case
		JMP LABEL7											; false case

LABEL6:
		MOV RDI, [RBP + 16]
		MOV BX, [RBP + 26]
		MOV CX, [RBP - 2]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV BX, [RDI + RBX]

		PUSH BX
		MOV AX, [RBP - 4]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETGE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		MOV [RBP - 6], AX										; store variable


		JMP LABEL8

LABEL7:
		MOV RDI, [RBP + 16]
		MOV BX, [RBP + 26]
		MOV CX, [RBP - 2]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV BX, [RDI + RBX]

		PUSH BX
		MOV AX, [RBP - 4]
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETLE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		MOV [RBP - 6], AX										; store variable


		JMP LABEL8

LABEL8:

		MOV AX, [RBP - 6]										; loading switch variable

		CMP AX, 0
		JNE LABEL9											; true case
		JMP LABEL10											; false case

LABEL9:

		JMP LABEL11

LABEL10:
		MOV AX, 0
		MOV [RBP + 30], AX										; store variable


		JMP LABEL11

LABEL11:

		JMP LABEL5

LABEL4:

		JMP LABEL5

LABEL5:
		MOV RDI, [RBP + 16]
		MOV BX, [RBP + 26]
		MOV CX, [RBP - 2]
		MOV DX, [RBP + 24]
		CALL @boundCheck										; checking array index bound
		MOV AX, [RDI + RBX]

		MOV [RBP - 4], AX										; store variable

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

		JMP WHILE1

	WHILE2:

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
		ADD RSP, RAX

		ret

@printGetArrPrompt:
		MOV SI, CX
		SUB SI, BX
		ADD SI, 1
		MOVSX RSI, SI
		XOR RAX, RAX
		PUSH BX
		PUSH CX
		CALL printf
		POP CX
		POP BX

		MOV RDI, @leftRange
		MOVSX RSI, BX
		XOR RAX, RAX
		PUSH BX
		PUSH CX
		CALL printf
		POP CX
		POP BX

		MOV RDI, @rightRange
		MOVSX RSI, CX
		XOR RAX, RAX
		PUSH BX
		PUSH CX
		CALL printf
		POP CX
		POP BX

		ret

@getArr:
		MOV RAX, RSP
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX

		PUSH RDI
		MOV RCX, 0

	.getArrLoop:								; getting array
		MOV RDI, @inputInt
		MOV RSI, RSP
		SUB RSI, 24
		PUSH RCX
		PUSH RDX
		PUSH RSI
		CALL scanf
		POP RSI
		POP RDX
		POP RCX
		MOV RBX, RCX
		MOV AX, [RSP - 24]
		POP RDI
		PUSH RDI
		MOV [RDI + RBX], AX

		ADD RCX, 2
		CMP RCX, RDX
		JNE .getArrLoop

		POP RDI
		POP RAX
		ADD RSP, RAX

		ret

@printInteger:
		MOV RDI, @printFormat
		MOVSX RSI, SI
		XOR RAX, RAX
		CALL printf

		ret

@printBoolean:
		CMP SI, 0
		JE .boolFalse
		MOV RDI, @printTrue
		JMP .boolPrint

	.boolFalse:
		MOV RDI, @printFalse

	.boolPrint:
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
		@printFormat : db "Output :  %d" , 10, 0
		@printTrue : db "Output : true" , 10, 0
		@printFalse : db "Output : false" , 10, 0
		@inputIntPrompt : db "Enter an integer : " , 0
		@inputBoolPrompt : db "Enter a boolean (0 for false, non-zero for true) : " , 0
		@inputIntArrPrompt : db "Enter %d array elements of integer type for range ", 0
		@leftRange : db "%d to " , 0
		@rightRange : db "%d" ,10, 0
		@inputInt : db "%d", 0
