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

		SUB RSP, 4											; making space for declaration

		SUB RSP, 6											; making space for declaration

		SUB RSP, 6											; making space for declaration

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

		MOV CX, 4
		MOV DX, 6
		MOV RDI, RBP
		SUB RDI, 16
		MOV RSI, RBP
		SUB RSI, 10
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @asgnArr

		MOV RDI, RBP
		SUB RDI, 16
		MOV CX, 4
		MOV DX, 6
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

@asgnArr:
		MOV CX, 0

	.assnLoop:
		MOVSX RBX, CX
		MOV AX, [RSI + RBX]
		MOV [RDI + RBX], AX

		ADD CX, 2
		CMP CX, DX
		JNE .assnLoop

		ret

;--------------------------------------------------------------------------------------------------

section .data
		@printFormatArray : db "Output : " , 0
		@printInt : db "%d ", 0
		@printNewLine : db 10, 0
		@inputIntArrPrompt : db "Enter %d array elements of integer type for range ", 0
		@leftRange : db "%d to " , 0
		@rightRange : db "%d" ,10, 0
		@inputInt : db "%d", 0
