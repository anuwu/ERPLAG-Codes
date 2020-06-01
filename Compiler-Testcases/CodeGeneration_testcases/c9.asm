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

		SUB RSP, 2											; making space for declaration

		MOV AX, 19
		MOV [RBP - 4], AX										; store variable

		MOV AX, 56
		MOV [RBP - 6], AX										; store variable

		MOV CX,3
		MOV [RBP - 10], CX
	@FOR1:
		MOV AX, 6
		CMP CX, AX
		JG @FOR2


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -2
		CALL @getValuePrimitive


		MOV AX, [RBP - 2]										; loading switch variable

		CMP AX, 1											; switch case
		JE @SWITCH1

		CMP AX, 2											; switch case
		JE @SWITCH2

		JMP @SWITCH3											; default case

@SWITCH1:
		MOV BX, [RBP - 10]
		PUSH BX
		MOV BX, [RBP - 4]
		PUSH BX
		MOV BX, 2
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		IMUL BX
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 4], AX										; store variable

		MOV SI, [RBP - 4]
		CALL @printInteger


		JMP @SWITCH4

@SWITCH2:
		MOV BX, [RBP - 10]
		PUSH BX
		MOV BX, [RBP - 6]
		PUSH BX
		MOV BX, 3
		PUSH BX
		MOV AX, [RBP - 2]
		PUSH AX
		POP AX
		POP BX
		IMUL BX
		PUSH AX
		POP AX
		POP BX
		SUB AX,BX
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 6], AX										; store variable

		MOV SI, [RBP - 6]
		CALL @printInteger


		JMP @SWITCH4

@SWITCH3:
		MOV SI, [RBP - 2]
		CALL @printInteger


		JMP @SWITCH4

@SWITCH4:
		MOV SI, [RBP - 4]
		CALL @printInteger

		MOV SI, [RBP - 6]
		CALL @printInteger


		MOV CX, [RBP - 10]								; For loop increment
		INC CX
		MOV [RBP - 10],CX
		JMP @FOR1

	@FOR2:

		MOV RSP, RBP
		POP RBP
		MOV RAX, 0x2000001
		XOR RDI, RDI
		syscall

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

;--------------------------------------------------------------------------------------------------

section .data
		@printFormat : db "Output :  %d" , 10, 0
		@inputIntPrompt : db "Enter an integer : " , 0
		@inputInt : db "%d", 0
