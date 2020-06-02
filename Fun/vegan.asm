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

		SUB RSP, 4											; making space for declaration


		MOV RDI, @inputBoolPrompt									; get_value
		MOV RBX, -2
		CALL @getValuePrimitive

		SUB RSP, 2
		MOV AX, [RBP - 2]
		PUSH AX
		CALL isVegan											; calling user function
		ADD RSP, 2
		POP AX
		MOV [RBP - 4], AX

		MOV SI, [RBP - 4]
		CALL @printBoolean


		MOV RSP, RBP
		POP RBP
		MOV RAX, 60
		XOR RDI, RDI
		syscall

;--------------------------------------------------------------------------------------------------

isVegan:
		PUSH RBP
		MOV RBP, RSP


		MOV AX, [RBP + 16]										; loading switch variable

		CMP AX, 0
		JNE @SWITCH1											; true case
		JMP @SWITCH2											; false case

@SWITCH1:
		MOV AX, 0
		MOV [RBP + 18], AX										; store variable


		JMP @SWITCH3

@SWITCH2:
		MOV AX, 1
		MOV [RBP + 18], AX										; store variable


		JMP @SWITCH3

@SWITCH3:

		MOV RSP, RBP
		POP RBP
		ret

;--------------------------------------------------------------------------------------------------

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

@printBoolean:
		MOV RAX, RSP									; Stack Alignment
		AND RAX, 15
		ADD RAX, 8
		SUB RSP, RAX
		PUSH RAX
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

		POP RAX
		ADD RSP, RAX									; Restoring Stack Alignment

		ret

;--------------------------------------------------------------------------------------------------

section .data
		@printTrue : db "Output : true" , 10, 0
		@printFalse : db "Output : false" , 10, 0
		@inputBoolPrompt : db "Enter a boolean (0 for false, non-zero for true) : " , 0
		@inputInt : db "%d", 0
