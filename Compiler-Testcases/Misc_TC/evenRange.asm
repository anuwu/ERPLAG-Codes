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

		SUB RSP, 8											; making space for declaration

		SUB RSP, 2											; making space for declaration


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -2
		CALL @getValuePrimitive


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -4
		CALL @getValuePrimitive

		MOV AX, 0
		MOV [RBP - 8], AX										; store variable


	@WHILE1:
		MOV BX, [RBP - 4]
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
		JE @WHILE2

		SUB RSP, 2											; making space for declaration

		MOV AX, 0
		MOV [RBP - 10], AX										; store variable

		MOV AX, [RBP - 2]
		MOV [RBP - 6], AX										; store variable

		MOV AX, 1
		MOV [RBP - 12], AX										; store variable


	@WHILE3:
		MOV BX, [RBP - 6]
		PUSH BX
		MOV AX, [RBP - 12]
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

		MOV BX, [RBP - 6]
		PUSH BX
		MOV BX, [RBP - 12]
		PUSH BX
		MOV AX, 2
		PUSH AX
		POP AX
		POP BX
		IMUL BX
		PUSH AX
		POP AX
		POP BX
		CMP AX,BX
		SETE AL
		MOVSX AX, AL
		PUSH AX
		POP AX
		MOV [RBP - 10], AX										; store variable


		MOV AX, [RBP - 10]										; loading switch variable

		CMP AX, 0
		JNE @SWITCH1											; true case
		JMP @SWITCH2											; false case

@SWITCH1:
		MOV AX, [RBP - 6]
		MOV [RBP - 12], AX										; store variable

		MOV SI, [RBP - 2]
		CALL @printInteger

		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 8]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 8], AX										; store variable


		JMP @SWITCH3

@SWITCH2:

		JMP @SWITCH3

@SWITCH3:
		MOV BX, 1
		PUSH BX
		MOV AX, [RBP - 12]
		PUSH AX
		POP AX
		POP BX
		ADD AX,BX
		PUSH AX
		POP AX
		MOV [RBP - 12], AX										; store variable

		JMP @WHILE3

	@WHILE4:
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


		ADD RSP, 2										; restoring to parent scope
		JMP @WHILE1

	@WHILE2:
		MOV SI, [RBP - 8]
		CALL @printInteger


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
