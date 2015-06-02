TITLE Programming Assignment #4 Accumulator    (Project04.asm)

; Author:									Andrew Pierno
; Description:
; Write a program to calculate composite numbers. First, the user is instructed to enter the number of composites to be displayed,
; and is prompted to enter an integer in the range [1 .. 400]. The user enters a number, n, and the program verifies that 1 <= n <= 400.
; If n is out of range, the user is re- prompted until s/he enters a value in the specified range. The program then calculates and
; displays all of the composite numbers up to and including the nth composite. The results should be displayed 10 composites per line
; with at least 3 spaces between the numbers.


INCLUDE Irvine32.inc

.data

welcome					   BYTE	  "Welcome to Composites by Andrew Pierno.", 0
instructions_1			   BYTE	  "Please enter a number between [1, 400] to see all ",0
instructions_2			   BYTE   "of the composites up to and including the number you entered", 0
instructions_3			   BYTE   "Please enter a number between 1 and 400.", 0
belowError				   BYTE   "The number you entered was too small. ", 0
aboveError				   BYTE   "The number you entered was too big. ", 0
spaces					   BYTE	  "   ", 0
goodbye					   BYTE	  "Tchau for now!", 0
number					   DWORD  ?
count					   DWORD  1

userNumber				   DWORD  ?
userNumberTemp			   DWORD  ?
innerLoopCount			   DWORD  ?
outerLoopCount			   DWORD  ?
underScore				   BYTE	  " _ ", 0
barr					   BYTE	  " | ", 0
outerCompare			   DWORD  ?
innerCompare			   DWORD  ?
writeCount				   DWORD  0
tenn				       DWORD  10



;constants
LOWERLIMIT		=		 1
UPPERLIMIT		=		 400

;change text color, because white text is a little boring after a while
val1 DWORD 11
val2 DWORD 16


.code
 main PROC

	call changeColor
	call introduction
	call getUserData
		;validate
	call showComposites
		;validate is composite
	call farewell

	exit
main ENDP

changeColor PROC

	; Set text color to teal
		mov  eax, val2
		imul eax, 16
		add  eax, val1
		call setTextColor
		ret
changeColor	ENDP

introduction PROC

	; Programmer name and title of assignment
	call	 CrLf
	mov		 edx, OFFSET welcome
	call	 WriteString
	call	 CrLf

	; assignment instructions
	mov		edx, OFFSET instructions_1
	call	WriteString
	mov		edx, OFFSET instructions_2
	call	WriteString
	call	CrLf
	mov		ecx, 0
	ret

introduction ENDP

getUserData PROC

	; loop to allow user to continue entering negative numbers
	userNumberLoop:
					mov		eax, count
					add		eax, 1
					mov		count, eax
					mov		edx, OFFSET instructions_3
					call	WriteString
					call	CrLf
					call    ReadInt
					mov     userNumber, eax
					cmp		eax,LOWERLIMIT
					jb		errorBelow
					cmp		eax, UPPERLIMIT
					jg		errorAbove
					jmp		continue
	;validation

	errorBelow:
					mov		edx, OFFSET belowError
					call	WriteString
					call	CrLf
					jmp		userNumberLoop
	errorAbove:
					mov		edx, OFFSET aboveError
					call	WriteString
					call	CrLf
					jmp		userNumberLoop
	continue:
					; prep the loop
					mov		ecx, 4
					mov		userNumberTemp, ecx

					cmp		ecx, userNumber
					ja		farewell

	ret
getUserData ENDP


showComposites PROC

		; for inner loop
		mov		eax, userNumber
		sub		eax, 2
		mov		innerLoopCount, eax

		; for outer loop
		mov		eax, userNumber
		sub		eax, 3
		mov		outerLoopCount, eax
		mov		ecx, outerLoopCount
		mov		eax, 4
		mov		outerCompare, eax

		; reset inner loop after each complete inner loop cycle
		mov		eax, 2
		mov		innerCompare, eax
		call	CrLf

		outerLoop:
				skipCarry:
					mov		eax, 2
					mov		innerCompare, eax
					mov		eax, outerCompare
					push	ecx
					push	eax
					mov		ecx, innerLoopCount

				isComposite:
							mov		eax, outerCompare
							mov		edx, 0
							div		innerCompare
							cmp		edx, 0
							jne		skipPrint
							; print out Composites
							mov		eax, outerCompare
							call	WriteDec
							mov		edx, OFFSET spaces
							call	WriteString
							mov		ebx, writeCount
							inc		ebx
							mov		writeCount, ebx
							cmp		ebx, 10
							jne		exitInnerLoop
							call	CrLf
							mov		writeCount,esi
							jmp		exitInnerLoop

							skipPrint:

							mov		ebx, innerCompare

							sub		eax, 1
							cmp		eax, ebx
							jae		skipIncrement
							add		eax, 1
							mov		innerCompare, eax
							skipIncrement:
							loop isComposite
							exitInnerLoop:

				pop		eax
				pop		ecx
				inc		eax
				mov		outerCompare, eax
				loop	outerLoop

	ret
showComposites ENDP

farewell PROC
	; say goodbye
	call	CrLf
	mov		edx, OFFSET goodbye
	call	WriteString
	call	CrLf
	call	CrLf
	exit
farewell ENDP
END main
