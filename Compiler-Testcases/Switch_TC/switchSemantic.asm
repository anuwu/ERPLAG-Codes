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

		SUB RSP, 6											; making space for declaration


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -4
		CALL @getValuePrimitive


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -6
		CALL @getValuePrimitive


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -8
		CALL @getValuePrimitive

		SUB RSP, 12											; making space for declaration

		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX

		MOV AX, [RBP - 4]
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
		MOV AX, 1
		MOV [RBP - 2], AX										; store variable

		SUB RSP, 12											; declaring before switch

		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX

		MOV AX, [RBP - 4]
		MOV BX, [RBP - 6]
		CALL @dynamicDeclCheck										; checking dynamic array declaration limits


		PUSH BX												; saving register for malloc
		PUSH AX												; saving register for malloc
		SUB RSP, 12
		CALL _malloc
		ADD RSP, 12
		MOV [RBP - 32], RAX
		POP SI
		MOV [RBP - 22], SI
		POP DI
		MOV [RBP - 24], DI


		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment

		MOV AX, [RBP - 8]										; loading switch variable

		CMP AX, 1											; switch case
		JE @SWITCH1

		CMP AX, 2											; switch case
		JE @SWITCH2

		CMP AX, 3											; switch case
		JE @SWITCH3

		JMP @SWITCH4											; default case

@SWITCH1:
		MOV SI, [RBP - 8]
		CALL @printInteger


		JMP @SWITCH5

@SWITCH2:
		MOV AX, 1
		NEG AX
		MOV [RBP - 4], AX										; store variable

		MOV SI, [RBP - 4]
		CALL @printInteger

		MOV SI, [RBP - 6]
		CALL @printInteger


		JMP @SWITCH5

@SWITCH3:
		MOV AX, 1
		NEG AX
		MOV [RBP - 6], AX										; store variable

		MOV SI, [RBP - 4]
		CALL @printInteger

		MOV SI, [RBP - 6]
		CALL @printInteger


		JMP @SWITCH5

@SWITCH4:
		MOV RDI, @inputIntArrPrompt
		MOV BX, [RBP - 22]
		MOV CX, [RBP - 24]
		CALL @printGetArrPrompt

		MOV DX, CX
		SUB DX, BX
		ADD DX, 1
		ADD DX, DX
		MOVSX RDX, DX
		MOV RDI, [RBP - 32]
		CALL @getArr

		MOV RDI, [RBP - 32]
		MOV CX, [RBP - 22]
		MOV DX, [RBP - 24]
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @printIntegerArr

		MOV AX, 0
		MOV [RBP - 2], AX										; store variable


		JMP @SWITCH5

@SWITCH5:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX

		MOV RDI, [RBP - 32]
		CALL _free								; freeing local dynamic arrays


		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment
		ADD RSP, 12											; restoring to parent scope
		SUB RSP, 4											; declaring before switch


		MOV AX, [RBP - 2]										; loading switch variable

		CMP AX, 0
		JNE @SWITCH6											; true case
		JMP @SWITCH7											; false case

@SWITCH6:
		MOV AX, 0
		MOV [RBP - 24], AX										; store variable

		MOV AX, 1
		MOV [RBP - 22], AX										; store variable

		MOV RDI, RBP
		SUB RDI, 24
		MOV CX, 0
		MOV DX, 1
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @printBooleanArr


		JMP @SWITCH8

@SWITCH7:
		MOV AX, 1
		MOV [RBP - 24], AX										; store variable

		MOV AX, 0
		MOV [RBP - 22], AX										; store variable

		MOV RDI, RBP
		SUB RDI, 24
		MOV CX, 0
		MOV DX, 1
		SUB DX, CX
		ADD DX, 1
		ADD DX, DX
		CALL @printBooleanArr


		JMP @SWITCH8

@SWITCH8:
		ADD RSP, 4											; restoring to parent scope
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX

		MOV RDI, [RBP - 20]
		CALL _free								; freeing local dynamic arrays


		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment

		MOV RSP, RBP
		POP RBP
		MOV RAX, 0x2000001
		XOR RDI, RDI
		syscall

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

@printGetArrPrompt:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		MOV SI, CX
		SUB SI, BX
		ADD SI, 1
		MOVSX RSI, SI
		XOR RAX, RAX
		PUSH RSI
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		CALL _printf
		POP DX
		POP CX
		POP BX
		POP AX
		POP RSI

		MOV RDI, @leftRange
		MOVSX RSI, BX
		XOR RAX, RAX
		PUSH RSI
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		CALL _printf
		POP DX
		POP CX
		POP BX
		POP AX
		POP RSI

		MOV RDI, @rightRange
		MOVSX RSI, CX
		XOR RAX, RAX
		PUSH RSI
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		CALL _printf
		POP DX
		POP CX
		POP BX
		POP AX
		POP RSI

		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment

		ret

@getArr:
		MOV RAX, RSP									; Stack Alignment
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
		CALL _scanf
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
		ADD RSP, RAX									; Restoring Stack Alignment

		ret

@printInteger:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
		MOV RDI, @printFormat
		MOVSX RSI, SI
		XOR RAX, RAX
		CALL _printf

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

@printBooleanArr:
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

		CMP SI, 0
		JE .arrFalse
		MOV RDI, @true
		JMP .afterBool

	.arrFalse:
		MOV RDI, @false

	.afterBool:
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
		@declPrint : db "[1m[31mRuntime Error [0m[1m--> [0mInvalid order of bounds in dynamic array declaration. Halt!" , 10, 0
		@declNeg : db "[1m[31mRuntime Error [0m[1m--> [0mNegative bound in dynamic array declaration. Halt!" , 10, 0
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
