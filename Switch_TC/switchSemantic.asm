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
		SUB RSP, 6											; making space for declaration

		MOV RDI, @inputIntPrompt							; get_value
		MOV RBX, -4
		CALL @getValuePrimitive


		MOV RDI, @inputIntPrompt							; get_value
		MOV RBX, -6
		CALL @getValuePrimitive


		MOV RDI, @inputIntPrompt							; get_value
		MOV RBX, -8
		CALL @getValuePrimitive

		SUB RSP, 12											; making space for declaration

		MOV AX, [RBP - 4]
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

		MOV BX, 1
		PUSH BX
		POP AX
		MOV [RBP - 2], AX									; store variable

		SUB RSP, 12											; declaring before switch

		MOV AX, [RBP - 4]
		MOV BX, [RBP - 6]
		CALL @dynamicDeclCheck

		PUSH BX												; saving register for malloc
		PUSH AX												; saving register for malloc
		CALL malloc
		MOV [RBP - 32], RAX
		POP AX
		MOV [RBP - 22], AX
		POP BX
		MOV [RBP - 24], BX


		MOV AX, [RBP - 8]									; loading switch variable

		CMP AX, 1											; switch case
		JE LABEL1

		CMP AX, 2											; switch case
		JE LABEL2

		CMP AX, 3											; switch case
		JE LABEL3

		JMP LABEL4											; default case

LABEL1:
		MOV SI, [RBP - 8]
		CALL @printInteger


		JMP LABEL5

LABEL2:
		MOV AX, 1
		PUSH AX
		POP AX
		NEG AX
		MOV [RBP - 4], AX									; store variable

		MOV SI, [RBP - 4]
		CALL @printInteger

		MOV SI, [RBP - 6]
		CALL @printInteger


		JMP LABEL5

LABEL3:
		MOV AX, 1
		PUSH AX
		POP AX
		NEG AX
		MOV [RBP - 6], AX									; store variable

		MOV SI, [RBP - 4]
		CALL @printInteger

		MOV SI, [RBP - 6]
		CALL @printInteger


		JMP LABEL5

LABEL4:
		MOV RDI, @inputIntArrPrompt
		MOV BX, [RBP - 22]
		MOV CX, [RBP - 24]
		CALL @printGetArrPrompt

		MOV RDI, [RBP - 32]
		MOV DX, CX
		SUB DX, BX
		ADD DX, 1
		ADD DX, DX
		MOVSX RDX, DX
		CALL @getArr

		MOV RDI, [RBP - 32]
		MOV CX, [RBP - 22]
		MOV DX, [RBP - 24]
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @printIntegerArr

		MOV BX, 0
		PUSH BX
		POP AX
		MOV [RBP - 2], AX									; store variable


LABEL5:
		MOV RDI, [RBP - 32]
		CALL free
		ADD RSP, 12											; restoring to parent scope
		SUB RSP, 4											; declaring before switch

		MOV AX, [RBP - 2]									; loading switch variable

		CMP AX, 0
		JNE LABEL6											; true case
		JMP LABEL7											; false case

LABEL6:
		MOV BX, 0
		PUSH BX
		POP AX
		MOV [RBP - 24], AX									; store variable

		MOV BX, 1
		PUSH BX
		POP AX
		MOV [RBP - 22], AX									; store variable

		MOV RDI, RBP
		SUB RDI, 24
		MOV CX, 0
		MOV DX, 1
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @printBooleanArr


		JMP LABEL8

LABEL7:
		MOV BX, 1
		PUSH BX
		POP AX
		MOV [RBP - 24], AX									; store variable

		MOV BX, 0
		PUSH BX
		POP AX
		MOV [RBP - 22], AX									; store variable

		MOV RDI, RBP
		SUB RDI, 24
		MOV CX, 0
		MOV DX, 1
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @printBooleanArr


		JMP LABEL8

LABEL8:
		ADD RSP, 4											; restoring to parent scope

		MOV RDI, [RBP - 20]
		CALL free

		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

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

@printBooleanArr:

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
		MOVSX RBX, CX
		MOV AX, [RDI + RBX]
		PUSH RDI

		CMP AX, 0
		JE .arrFalse
		MOV RDI, @true
		JMP .afterBool

	.arrFalse:
		MOV RDI, @false

	.afterBool:
		XOR RSI, RSI
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
		@declPrint : db "RUNTIME ERROR : Invalid order of bounds in dynamic array declaration" , 10, 0
		@declNeg : db "RUNTIME ERROR : Negative bound in dynamic array declaration" , 10, 0
		@printFormatArray : db "Output : " , 0
		@printInt : db "%d ", 0
		@printNewLine : db 10, 0
		@printFormat : db "Output :  %d" , 10, 0
		@true : db "true " , 0
		@false : db "false " , 0
		@inputIntPrompt : db "Enter an integer : " , 0
		@inputIntArrPrompt : db "Enter %d array elements of integer type for range ", 0
		@leftRange : db "%d to " , 0
		@rightRange : db "%d" ,10, 0
		@inputInt : db "%d", 0
