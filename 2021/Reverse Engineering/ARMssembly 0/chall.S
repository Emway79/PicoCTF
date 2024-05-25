	.arch armv8-a			@ Assembler language = ARMV8-a
	.file	"chall.c"
	.text
	.align	2
	.global	func1
	.type	func1, %function

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Description: 		Finds the maximum value of both arguments.				  @
@																			  @
@ Arguments: 		1. u32 num1 (int 1)										  @
@				    2. u32 num2 (int 2)									      @
@																			  @
@ Simplification: 	If (num1 <= num2) {										  @
@						return num2;									 	  @
@					} else {												  @
@						return num1;										  @
@					}											  			  @
@																			  @
@ Returns:			The maximum value of both arguments.					  @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
func1:
	sub	sp, sp, #16       	 @ SP = SP - 16									@ Reserve 16 bytes on the stackframe			
	str	w0, [sp, 12]	 	 @ Store 32 bit value in W0 at [SP + 12]		@ Store 1st argument in bytes 12-15 on the stackframe
	str	w1, [sp, 8]		 	 @ Store 32 bit value in W1 at [SP + 8]			@ Store 2nd argument in bytes 8-11 on the stackframe
	ldr	w1, [sp, 12]	 	 @ Load 32 bit value from [SP + 12] into W1		@ Load 1st argument into W1 
	ldr	w0, [sp, 8]		 	 @ Load 32 bit value from [SP + 8] into W0		@ Load 2nd argument into W0
	cmp	w1, w0			 	 @ Compare the values in W1 and W0				@ Compare 1st and 2nd arguments 
	bls	.L2			     	 @ Branch to the L2 label if W1 <= W0			@ Goto L2 if 1st argument <= 2nd argument
	ldr	w0, [sp, 12]	 	 @ Load 32 bit value from [SP + 12] in W0		@ Load 1st argument into W0
	b	.L3				 	 @ Branch to the L3 label						@ Goto L3

.L2:
	ldr	w0, [sp, 8]			 @ Load 32 bit value from SP + 8 in W0			@ Load 2nd argument into W0

.L3:
	add	sp, sp, 16		 	 @ SP = SP + 16									@ Reclaim the 16 bytes of reserved stack space		
	ret					 	 @ Return from subroutine						@ Return (registers W0 and W1 have side effects) 
	.size	func1, .-func1
	.section	.rodata
	.align	3

.LC0:
	.string	"Result: %ld\n"
	.text
	.align	2
	.global	main
	.type	main, %function

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Description: 		Takes two 32bit numbers in string representation from     @
@					the command line, converts them to integers and then 	  @ 
@					prints the maximum of the two to the standard output.	  @
@																			  @
@ Arguments: 		1. u32 W0 (int argc = command line argument count) 		  @
@				    2. char** X1 (char** argv = command line argument array)  @
@	      				  [Path, 1st argument, 2nd argument]		  		  @
@																			  @
@ Simplification: 	u32 num1 = stringToInt(arg1);							  @
@					u32 num2 = stringtoInt(arg2);							  @
@					u32 max = max(num1, num2);								  @
@					printf("Result: %ld\n", max);							  @
@					return 0;								  				  @
@ 																			  @
@ Returns: 			0 if succesfull, otherwise an error code.				  @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
main:
	stp	x29, x30, [sp, -48]! @ Push X29 and X30 onto the stack				@ Store stack pointer and return pointer on the stack 
	add	x29, sp, 0 	     	 @ X29 = SP + 0									@ Copy the stack pointer to X29 
	str	x19, [sp, 16]	 	 @ Store 64 bit value in X19 at [SP + 16]		@ Store X19 at byte 16-23 on the stackframe
	str	w0, [x29, 44]    	 @ Store 32 bit value in W0 at [X29 + 44]		@ Store last 32 bits from the 1st argument (argc) at byte 44-47 on the stackframe
	str	x1, [x29, 32]    	 @ Store 64 bit value in X1 at [X29 + 32]		@ Store the 2nd argument (argv) at byte 32-39 on the stackframe
	ldr	x0, [x29, 32]    	 @ Load 64 bit value from [X29 + 32] into X0    @ Load the address of the command line argument array in X0
	add	x0, x0, 8		 	 @ X0 = X0 + 8									@ Address is incremented by 8 bytes and becomes the address of the 1st argument
	ldr	x0, [x0]         	 @ Load 64 bit value from [X0] into X0			@ Load the value at the 1st argument address into X0
	bl	atoi		     	 @ Branch link to atoi function					@ Convert the data at the 1st argument address to an integer
	mov	w19, w0			  	 @ Copy W0 to W19								@ Copy the last 32 bits of converted integer to W19
	ldr	x0, [x29, 32]	  	 @ Load 64 bit value from [X29 + 32] into X0	@ Load the address of the command line argument array in X0
	add	x0, x0, 16       	 @ X0 = X0 + 16									@ Address is incremented by 16 bytes and becomes the address of the 2nd argument
	ldr	x0, [x0]         	 @ Load 64 bit value from X0 in X0				@ Load the 2nd argument address into X0
	bl	atoi			 	 @ Branch link to atoi function					@ Convert the data at the 2nd argument address to an integer
	mov	w1, w0			 	 @ Copy W0 to W1								@ Copy last 32 bits of the 2nd integer to W1
	mov	w0, w19			 	 @ Copy W19 to W0								@ Copy the 1st integer back to W0
	bl	func1			 	 @ Branch link to func1 subroutine				@ Execute subroutine: func1(W0, W1)
	mov	w1, w0			 	 @ Copy W0 to W1								@ Copy result of W0 to W1
	adrp 	x0, .LC0     	 @ Copy address of LC0 label into X0			@ Copy the address (bits 63 - 12) of the LC0 label into the X0 register
	add	x0, x0, :lo12:.LC0	 @ Copy address of LC0 label into X0			@ Add the address (bits 11 - 0) of the LC0 label to the X0 register
	bl	printf				 @ Branch link to printf subroutine				@ Execute subroutine: printf("Result: %ld\n", W1)
	mov	w0, 0				 @ Copy 0 to W0									@ Set return value to 0 (No error)
	ldr	x19, [sp, 16]		 @ Load 64 bit value from [SP + 16] into X19	@ Restore register X19
	ldp	x29, x30, [sp], 48	 @ Pop old X29 and X30 from the stack			@ Pop stack pointer and return address from the stack
	ret					     @ Return (end of program)						@ Return from main
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"", #progbits
