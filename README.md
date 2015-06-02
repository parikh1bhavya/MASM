# MASM
MASM x86

A few examples of MASM x86 Projects


# Project 1
 Description: Write and test a MASM program to perform the following tasks:

1. Display your name and program title on the output screen.
2. Display instructions for the user.
3. Prompt the user to enter two numbers.
4. Calculate the sum, difference, product, (integer) quotient and remainder of the numbers.
5. Display a terminating message.

# Project 2
Description: Write a program to calculate Fibonacci numbers.
1. Display the program title and programmer’s name. Then get the user’s name, and greet the user.
2. Prompt the user to enter the number of Fibonacci terms to be displayed. Advise the user to enter an integer in the range [1 .. 46].
3. Get and validate the user input (n).
4. Calculate and display all of the Fibonacci numbers up to and including the nth term. The results should be displayed 5 terms per line with at least 5 spaces between terms.
5. Display a parting message that includes the user’s name, and terminate the program.

# Project 3
 Description:
1. Display the program title and programmer’s name.
2. Get the user’s name, and greet the user.
3. Display instructions for the user.
4. Repeatedly prompt the user to enter a number. Validate the user input to be in [-100, -1] (inclusive).
		Count and accumulate the valid user numbers until a non-negative number is entered. (The non-
		negative number is discarded.)
5. Calculate the (rounded integer) average of the negative numbers. 6. Display:
	i. the number of negative numbers entered (Note: if no negative numbers were entered, display a special message and skip to iv.)
	ii. the sum of negative numbers entered
	iii. the average, rounded to the nearest integer (e.g. -20.5 rounds to -20)
	iv. a parting message (with the user’s name)

# Project 4
 Description:
 Write a program to calculate composite numbers. First, the user is instructed to enter the number of composites to be displayed, and is prompted to enter an integer in the range [1 .. 400]. The user enters a number, n, and the program verifies that 1 <= n <= 400.

 If n is out of range, the user is re- prompted until s/he enters a value in the specified range. The program then calculates and displays all of the composite numbers up to and including the nth composite. The results should be displayed 10 composites per line with at least 3 spaces between the numbers.

# Project 5
 Write and test a MASM program to perform the following tasks:
 1. Introduce the program.
 2. Get a user request in the range [min = 10 .. max = 200].
 3. Generate request random integers in the range [lo = 100 .. hi = 999], storing them in consecutive elements
 of an array.
 4. Display the list of integers before sorting, 10 numbers per line.
 5. Sort the list in descending order (i.e., largest first).
 6. Calculate and display the median value, rounded to the nearest integer. 7. Display the sorted list, 10 numbers per line.

# Project 6
 Description:
1. User’s numeric input must be validated the hard way: Read the user's input as a string, and convert the string to numeric form. If the user enters non-digits or the number is too large for 32-bit registers, an error message should be displayed and the number should be discarded.
2. Conversion routines must appropriately use the lodsb and/or stosb operators.
3. All procedure parameters must be passed on the system stack.
4. Addresses of prompts, identifying strings, and other memory locations should be passed by address to the macros.
5. Used registers must be saved and restored by the called procedures and macros.
6. The stack must be “cleaned up” by the called procedure.
7. The usual requirements regarding documentation, readability, user-friendliness, etc., apply.
