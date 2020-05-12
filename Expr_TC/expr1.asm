extern printf
extern scanf
extern malloc
extern exit

global main
section .text

main:
		PUSH RBP
		MOV RBP, RSP

		SUB RSP, 4											; making space for declaration


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -2
		CALL @getValuePrimitive


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -4
		CALL @getValuePrimitive

		SUB RSP, 6											; making space for declaration

		SUB RSP, 12											; making space for declaration


		MOV AX, [RBP - 2]
		MOV BX, [RBP - 4]
		CALL @dynamicDeclCheck										; checking dynamic array declaration limits


		PUSH BX												; saving register for malloc
		PUSH AX												; saving register for malloc
		CALL malloc
		MOV [RBP - 22], RAX
		POP AX
		MOV [RBP - 12], AX
		POP BX
		MOV [RBP - 14], BX

		MOV RDI, @inputIntArrPrompt
		MOV BX, 4
		MOV CX, 6
		CALL @printGetArrPrompt

		MOV RDI, RBP
		SUB RDI, 10
		MOV DX, CX
		SUB DX, BX
		ADD DX, 1
		ADD DX, DX
		MOVSX RDX, DX
		CALL @getArr

		MOV RDI, RBP
		SUB RDI, 10
		MOV CX, 4
		MOV DX, 6
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @printIntegerArr

		MOV AX, [RBP - 12]
		MOV CX, 4
		CMP AX, CX
		JE LABEL1
		CALL @asgnLimERROR

	LABEL1:
		MOV BX, [RBP - 14]
		MOV DX, 6
		CMP BX, DX
		JE LABEL2
		CALL @asgnLimERROR

	LABEL2:
		MOV RDI, RBP
		SUB RDI, 10
		MOV[RBP - 22], RDI
		MOV RDI, [RBP - 22]
		MOV CX, [RBP - 12]
		MOV DX, [RBP - 14]
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @printIntegerArr


		MOV RSP, RBP
		POP RBP
		MOV RAX, 1
		MOV RBX, 0
		INT 0x80

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

	.printArr:
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

@asgnLimERROR:
		MOV RDI, @asgnArgMismatch
		XOR RSI, RSI
		XOR RAX, RAX
		CALL printf
		MOV EDI, 0
		CALL exit

;--------------------------------------------------------------------------------------------------

section .data
		@declPrint : db "ERPLAG : Runtime Error --> Invalid order of bounds in dynamic array declaration" , 10, 0
		@declNeg : db "ERPLAG : Runtime Error --> Negative bound in dynamic array declaration" , 10, 0
		@asgnArgMismatch: db "ERPLAG : Runtime Error --> Mismatch of limits in array assignment" , 10, 0
		@printFormatArray : db "Output : " , 0
		@printInt : db "%d ", 0
		@printNewLine : db 10, 0
		@inputIntPrompt : db "Enter an integer : " , 0
		@inputIntArrPrompt : db "Enter %d array elements of integer type for range ", 0
		@leftRange : db "%d to " , 0
		@rightRange : db "%d" ,10, 0
		@inputInt : db "%d", 0
