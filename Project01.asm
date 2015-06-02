TITLE Programming Assignment #1    (Project01.asm)

; Author:									Andrew Pierno
;
; Description: Write and test a MASM program to perform the following tasks:
;	1. Display your name and program title on the output screen.
;	2. Display instructions for the user.
;	3. Prompt the user to enter two numbers.
;	4. Calculate the sum, difference, product, (integer) quotient and remainder of the numbers.
;	5. Display a terminating message.
;	EC: Validate second number is less than the first
; 	EC: Loop until user decides to quit
; 	EC: Calculates and displays division as floating point number rounded to .001

INCLUDE Irvine32.inc

.data
myName				BYTE	"Andrew Pierno ", 0
programTitle		BYTE	"Programming Assignment #1", 0
instructions		BYTE	"Please enter two numbers, and I'll show you the sum, difference, product, quotient, and remainder.", 0
prompt_1			BYTE	"First Number: ", 0
prompt_2			BYTE	"Second Number: ", 0
firstNumber			DWORD	?							 ; integer entered by user
secondNumber		DWORD	?							 ; second integer entered by user.
goodBye				BYTE	"Goodbye",0
equalsString		BYTE	" = ", 0
sum					DWORD	?
sumString			BYTE	" + ",0
difference			DWORD	?
differenceString	BYTE	" - ",0
product				DWORD	?
productString		BYTE	" * ",0
quotient			DWORD	?
quotientString		BYTE	" / ",0
remainder			DWORD	?
remainderString		BYTE	" remainder ",0

; Extra Credit
EC1prompt			BYTE	"**EC: This program verifies the second number is less than the first", 0
EC1warn				BYTE	"The second number must be less than the first!", 0
EC2prompt			BYTE	"**EC: This program also calculates and displays the quotient as a floating-point number, rounded to the nearest .001", 0
EC2string			BYTE	"EC: Floating-point value: ", 0
EC2FloatingPoint	REAL4	?	; short real single precision floating point variable
oneThousand			DWORD	1000						; to convert an int to a floating point number rounded to .001 (can be changed to increase or decrease precision)
bigInt			    DWORD	0							; represents the floating point number multiplied by 1000
ECremainder			DWORD	?							; for floating point creation
dot					BYTE	".",0						; to serve as the decimal place of a floating point number
firstPart			DWORD	?							; for the first part of the floating point representation of the quotient
secondPart			DWORD	?							; fot the part of the floating point number after the decimal place
temp				DWORD	?							; temporary holder for floating point creation
EC3prompt			BYTE	"EC: Would you like to play again? Enter 1 for YES or 0 for NO: ", 0
EC3explain			BYTE	"**EC: This program loops until the user decides to quit.", 0
EC3response			DWORD	?							; BOOL for user to loop or exit.

.code
 main PROC

	; Introduction
	; This section prints out the instructions and extra credit options

		mov		edx, OFFSET myName
		call	WriteString
		mov		edx, OFFSET programTitle
		call	WriteString
		call	CrLf
		mov		edx, OFFSET EC1prompt
		call	WriteString
		call	CrLf
		mov		edx, OFFSET EC2prompt
		call	WriteString
		call	CrLf
		mov		edx, OFFSET EC3explain
		call	WriteString
		call	CrLf

	; Get The Data
	; This section gets the first and second number and jumps if the user's second number is greater than the first number
	; the program will still allow them to loop even if they enter a second number that is greater than the first.
		mov		edx, OFFSET instructions
		call	WriteString
		call	CrLf

			; get firstNumber
top:
			mov		edx, OFFSET prompt_1
			call	WriteString
			call	ReadInt
			mov		firstNumber, eax


			; get secondNumber
			mov		edx, OFFSET prompt_2
			call	WriteString
			call	ReadInt
			mov		secondNumber, eax

			; **EC: Jump if second number greater than first
			mov		eax, secondNumber
			cmp		eax, firstNumber
			jg		Warning
			jle		Calculate

Warning:
			mov		edx, OFFSET EC1warn
			call	WriteString
			call	CrLf
			jg		JumpToLoop				; jump if secondNumber > firstNumber


Calculate:		; Calculate Required Values
				; sum
				mov		eax, firstNumber
				add		eax, secondNumber
				mov		sum, eax

				; difference
				mov		eax, firstNumber
				sub		eax, secondNumber
				mov		difference, eax

				; product
				mov		eax, firstNumber
				mov		ebx, secondNumber
				mul		ebx
				mov		product, eax


				; quotient
				mov		edx, 0
				mov		eax, firstNumber
				cdq
				mov		ebx, secondNumber
				cdq
				div		ebx
				mov		quotient, eax
				mov		remainder, edx

				; EC floating point representation of quotient and remainder
				fld		firstNumber					; load firstNumber (integer) into ST(0)
				fdiv	secondNumber				; divide firstNumber by secondNumber ?
				fimul	oneThousand
				frndint	
				fist	bigInt
				fst		EC2FloatingPoint			; take value off stack, put it in EC2FloatingPoint

			; Display Results

				; sum results
				mov		eax, firstNumber
				call	WriteDec
				mov		edx, OFFSET sumString
				call	WriteString
				mov		eax, secondNumber
				call	WriteDec
				mov		edx, OFFSET equalsString
				call	WriteString
				mov		eax, sum
				call	WriteDec
				call	CrLf

				; difference results
				mov		eax, firstNumber
				call	WriteDec
				mov		edx, OFFSET differenceString
				call	WriteString
				mov		eax, secondNumber
				call	WriteDec
				mov		edx, OFFSET equalsString
				call	WriteString
				mov		eax, difference
				call	WriteDec
				call	CrLf

				; product results
				mov		eax, firstNumber
				call	WriteDec
				mov		edx, OFFSET productString
				call	WriteString
				mov		eax, secondNumber
				call	WriteDec
				mov		edx, OFFSET equalsString
				call	WriteString
				mov		eax, product
				call	WriteDec
				call	CrLf

				; quotient results
				mov		eax, firstNumber
				call	WriteDec
				mov		edx, OFFSET quotientString
				call	WriteString
				mov		eax, secondNumber
				call	WriteDec
				mov		edx, OFFSET equalsString
				call	WriteString
				mov		eax, quotient
				call	WriteDec
				mov		edx, OFFSET remainderString
				call	WriteString
				mov		eax, remainder
				call	WriteDec
				call	CrLf

				; EC2 Output
				mov		edx, OFFSET EC2string
				call	WriteString
				mov		edx, 0
				mov		eax, bigInt
				cdq
				mov		ebx, 1000
				cdq
				div		ebx
				mov		firstPart, eax
				mov		ECremainder, edx
				mov		eax, firstPart
				call	WriteDec
				mov		edx, OFFSET dot
				call	WriteString

				;calculate remainder
				mov		eax, firstPart
				mul		oneThousand
				mov		temp, eax
				mov		eax, bigInt
				sub		eax, temp
				mov		secondPart, eax
				call	WriteDec
				call	CrLf

		; Loop until user quits
		; prompts the user to enter a 0 or 1 to continue looping.
		; if they do want to play again, it takes them to section 'top'
		; skipping the instrucitons

				; get response for loop

JumpToLoop:			mov		edx, OFFSET EC3prompt
					call	WriteString
					call	ReadInt
					mov		EC3response, eax
					cmp		eax, 1
					je		top				; jump to top if response == 1


				; Say Goodbye
					mov		edx, OFFSET goodBye
					call	WriteString
					call	CrLf

	exit	; exit to operating system
main ENDP

END main
