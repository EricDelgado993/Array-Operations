@ Author: Eric Delgado
@ CS 413-02 Fall 2023
@ Date: 9/5/2023
@
@ Filename: 413lab_1.s
@ Purpose:  Program initializes 3 arrays. Array 1 is is initalized by the code. 
@           Array 2 is populated by user input. Once A2 is populated, A3 is
@			populated by the result of A1[i] * A2[i]. Program demonstrates
@			use of auto indexing and push/pop routines.
@
@========================================================================
@ ASSEMBLE, LINK, RUN, DEBUG COMMANDS
@========================================================================
@
@    as -o 413lab_1.o 413lab_1.s
@    gcc -o 413lab_1 413lab_1.o
@    ./413lab_1
@	 s -o 413lab_1.o 413lab_1.s -g
@	 gcc -o 413lab_1 413lab_1.o -g
@    gdb ./413lab_1
@
@========================================================================
@ BEGIN PROGRAM
@========================================================================

.global main 	  			@ Have to use main because of C library uses
.arch armv6
.fpu vfp

main:						@ Start executing code

@========================================================================
@ WELCOME MESSAGE
@========================================================================

	ldr r0, =prompt_1		@ Load r0 with address of prompt_1
	bl printf				@ Display welcome message

@========================================================================
@ INITIALIZE REGISTERS
@========================================================================

	mov r4, #1				@ Iterator
	ldr r5, =clear			@ Buffer register used for print routine
	ldr r6, =clear			@ Result register. Holds value of A1[i] * A2[i]
	ldr r7, =ARR1			@ Initialized array. Put address of ARR1 in r7
	ldr r8, =ARR2			@ User input array. Put address of ARR2 in r8
	ldr r9, =ARR3			@ Result array. Put address of ARR3 in r9

@========================================================================
@ USER INPUT LOOP
@========================================================================

input_loop:					@ Keeps reading in user input until i > 10
	
	ldr r0, =format			@ Prepare r1 to take in int input
	ldr r1, =clear			@ Initialize r1 with address where value is stored
	bl scanf				@ Store value
	
	ldr r1, =clear			@ Initialize r1 with address where value is stored
	ldr r1, [r1]			@ Store numeric input value in r1
		
	str r1, [r8], #4		@ Store value within r1 to ARR2 (r8) element. Increment to next element
	
	add r4, r4, #1			@ Increment loop counter (i++)
	cmp r4, #10				@ Compare r4 value and 10
	BLE input_loop			@ i <= 10 condition, if true goto input_loop:

@========================================================================
@ CALCULATE A3[i] = A1[i] * A2[i]
@========================================================================

	mov r4, #1				@ Initialize iterator
	ldr r8, =ARR2			@ User input array. Put address of ARR2 in r8
	
calc_loop:					@ Keeps calculting and populating elements for array 3
							@ until i > 10

	ldr r1, [r7], #4		@ Store address of A1[i] element into r1
	ldr r2, [r8], #4		@ Store address of A2[i] element into r2
	
	mul r6, r1, r2			@ A1[i]*A2[i] store result in r6
	
	str r6, [r9], #4		@ Result val
	
	add r4, r4, #1			@ Increment loop counter (i++)
	cmp r4, #10				@ Compare r4 value and 10
	BLE calc_loop			@ i <= 10 condition, if true goto calc_loop:

@========================================================================
@ DISPLAY ARRAYS
@========================================================================

	ldr r0, =label_A		@ Access array 1 label
	bl printf				@ Print label
	
	ldr r5, =ARR1			@ Point to array 1 for printing
	bl printarray			@ Invoke printarray subroutine on array 1
	
	ldr r0, =label_B		@ Access array 2 label
	bl printf				@ Print label
	
	ldr r5, =ARR2			@ Point to array 2 for printing
	bl printarray			@ Invoke printarray subroutine on array 2
	
	ldr r0, =label_C		@ Access array 3 label
	bl printf				@ Print label
	
	ldr r5, =ARR3			@ Point to array 3 for printing
	bl printarray			@ Invoke printarray subroutine on array 3
	
@========================================================================
@ EXIT
@========================================================================

    mov r7, #0x01 			@ SVC call to exit
    svc 0         			@ Make the system call. 

@========================================================================
@ PRINT ARRAY ROUTINE
@========================================================================

printarray:					@ Subroutine prints contents of array using loop
							@ and push/pop routines

	ldr r0, = str_B			@ Load element print format
	
	push {r0, r1, r5, lr}	@ Push registers onto stack
	
	mov r4, #1				@ Initialize iterator
	
	printloop:				@ Print elements of array until i > 10
	
		ldr r1, [r5], #4	@ Load array element to r1. Point to next element
		bl printf			@ Print loaded element
	
		ldr r0, =str_B		@ Load element print format
	
		add r4, r4, #1		@ Increment loop counter (i++)
		cmp r4, #10			@ Compare r4 value and 10
		BLE printloop		@ i <= 10 condition, if true goto printloop:
	
	ldr r0, =str_A			@ Load an empty space for formatting
	bl printf				@ Print empty space
	
	pop {r0, r1, r5, pc}	@ Pop registers off stack

@========================================================================
@ DATA DECLARATIONS
@========================================================================

.data					@ Lets the OS know it is OK to write this area of memory.

.balign 4				@ Force a word boundary
prompt_1: .asciz "Welcome to the array program.\nInput positive integers.\n"

.balign 4				@ Force a word boundary
str_A:	.asciz "\n"

.balign 4				@ Force a word boundary
str_B:	.asciz "[ %d ]"

.balign 4				@ Force a word boundary
label_A: .asciz "\nArray A (initialized array):\n"

.balign 4				@ Force a word boundary
label_B: .asciz "\nArray B (user input array):\n"

.balign 4				@ Force a word boundary
label_C: .asciz "\nArray C (A[i] * B[i]):\n"

.balign 4				@ Force a word boundary
format:	.asciz "%d"

.balign 4				@ Force a word boundary
clear:	.word	0

.balign 4				@ Force a word boundary
ARR1:	.word	10, -20, 0, 40, -50, 0, 70, -80, 0, 100

.balign 4				@ Force a word boundary
ARR2:	.word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.balign 4				@ Force a word boundary
ARR3:	.word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.global printf
