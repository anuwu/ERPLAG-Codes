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


		MOV RDI, @inputIntPrompt									; get_value
		MOV RBX, -2
		CALL @getValuePrimitive

		MOV AX, [RBP - 2]
		PUSH AX
		CALL emptyMod											; calling user function
		ADD RSP, 2
		MOV SI, [RBP - 2]
		CALL @printInteger


		MOV RSP, RBP
		POP RBP
		MOV RAX, 0x2000001
		XOR RDI, RDI
		syscall

;--------------------------------------------------------------------------------------------------

emptyMod:
		PUSH RBP
		MOV RBP, RSP


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
