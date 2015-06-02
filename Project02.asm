TITLE Fibonacci Numbers    (Project02.asm)

; Author:									Andrew Pierno
; Description: Write a program to calculate Fibonacci numbers.
;	• Display the program title and programmer’s name. Then get the user’s name, and greet the user.
;	• Prompt the user to enter the number of Fibonacci terms to be displayed. Advise the user to enter an integer
;		in the range [1 .. 46].
;	• Get and validate the user input (n).
;	• Calculate and display all of the Fibonacci numbers up to and including the nth term. The results should be
;		displayed 5 terms per line with at least 5 spaces between terms.
;	• Display a parting message that includes the user’s name, and terminate the program.

INCLUDE Irvine32.inc

.data
myName				BYTE	"Andrew Pierno ", 0
programTitle		BYTE	"Fibonacci Numbers by ", 0
instructions		BYTE	"Please enter two numbers, and I'll show you the sum, difference, product, quotient, and remainder.", 0
prompt_1			BYTE	"What is your name? ", 0
prompt_2			BYTE	"Enter the number of Fibonacci terms you would like to see. Please enter a number between [1 - 46]", 0
ec_prompt			BYTE	"EC: Doing something awesome: Setting text color to teal-ish", 0
numFib				DWORD	?
prev1				DWORD	?
prev2				DWORD	?
spaces				BYTE	"     ",0
goodbye				BYTE	"Goodbye,  ", 0
firstTwo			BYTE	"1     1     ", 0
firstOne			BYTE	"1", 0
temp				DWORD	?
moduloFive			DWORD	5
UPPERLIMIT = 46
LOWERLIMIT = 1

;user's name
buffer				BYTE 21 DUP(0)
byteCount			DWORD	?

;greet user
hi					BYTE	"Hi, ",0

;validation
tooHighError		BYTE	"The number you entered is too high! It must be 46 or below. ", 0
tooLowError			BYTE	"The number you entered is too low! It must be 1 or above. ", 0

;EC -> Doing something awesome: Setting  Background Color and Text Color
val1 DWORD 11
val2 DWORD 16

.code
 main PROC

	;EC: doing something awesome like setting the text color

	; set text color to teal
		mov eax, val2
		imul eax, 16
		add eax, val1
		call setTextColor

	; INTRODUCTION
		mov		edx, OFFSET programTitle
		call	WriteString
		mov		edx, OFFSET myName
		call	WriteString
		call	CrLf

		; EC Prompt
		mov		edx, OFFSET ec_prompt
		call	WriteString
		call	CrLf


		mov		edx, OFFSET prompt_1
		call	WriteString
		call	CrLf


		; get user's name
		mov		edx, OFFSET buffer	;point to the buffer
		mov		ecx, SIZEOF	buffer	; specify max characters
		call	ReadString
		mov		byteCount, eax

		; greet the user
		mov		edx, OFFSET hi
		call	WriteString
		mov		edx, OFFSET buffer
		call	WriteString
		call	CrLf

	; USER INSTRUCTIONS
topPrompt:
			mov		edx, OFFSET prompt_2
			call	WriteString
			call	CrLf

	; GET USER DATA
		call	ReadInt
		mov		numFib, eax

	; Validate user data
		cmp		eax, UPPERLIMIT
		jg		TooHigh
		cmp		eax, LOWERLIMIT
		jl		TooLow
		je		JustOne
		cmp		eax, 2
		je		JustTwo

	; DISPLAY FIBS

		; prepare loop (post-test), do the first two manually

		mov		ecx, numFib
		sub		ecx, 3			; we start at iteration 3, the first two are taken care of by JustOne and JustTwo
		mov		eax, 1
		call	WriteDec
		mov		edx, OFFSET spaces
		call	WriteString
		call	WriteDec
		mov		edx, OFFSET spaces
		call	WriteString
		mov		prev2, eax
		mov		eax, 2
		call	WriteDec
		mov		edx, OFFSET spaces
		call	WriteString
		mov		prev1, eax

		fib:
			; add prev 2 to eax
			add		eax, prev2
			call	WriteDec

			mov		edx, OFFSET spaces
			call	WriteString

			mov		temp, eax
			mov		eax, prev1
			mov		prev2, eax
			mov		eax, temp
			mov		prev1, eax

			;for spacing (first time it should be % 3, rest %5)
			mov		edx, ecx
			cdq
			div		moduloFive
			cmp		edx, 0
			jne		skip
			call	CrLf

		skip:
				; restore what was on eax
				mov		eax, temp
				; if ecx % 3 = 0 call CrLf
				loop	fib
		jmp		TheEnd

TooHigh:
			mov		edx, OFFSET tooHighError
			call	WriteString
			jmp		TopPrompt

TooLow:
			mov		edx, OFFSET tooLowError
			call	WriteString
			jmp		TopPrompt
JustOne:
			mov		edx, OFFSET firstOne
			call	WriteString
			jmp		TheEnd

JustTwo:
			mov		edx, OFFSET firstTwo
			call	WriteString
			jmp		TheEnd

	; FAREWELL
TheEnd:
			call	CrLf
			mov		edx, OFFSET goodbye
			call	WriteString
			mov		edx, OFFSET buffer
			call	WriteString
			call	CrLf

	exit	; exit to operating system
main ENDP

END main
