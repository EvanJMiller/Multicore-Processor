//#Program 1
//---------------------------------------------------------------------
	org 0x0000 //start of the program

	ori $sp,$zero,0xfffc  //store the starting point of the stack
	ori $s3, $zero, 0x0001
	ori $s1, $zero, 0x0004
	ori $s2, $zero, 0x0003
	
//Push initial values onto the stack
	addi $sp, $sp, -8 //set up stack to push two values
	sw $s1, 8($sp) //push the first values onto the stack (4)
	sw $s2, 4($sp) //push the second value onto the stack (3)

MULTIPLY:
	ori $t0, $zero, 0x0000
	lw $t1, 8($sp) //pop / load first word off of the stack
	lw $t2, 4($sp) //pop / load second word off of the stack

Loop: 
	addu $t0, $t0, $t2 //add the running sum by the second number
	subu $t1, $t1, $s3 //decrement the first number
	bne $t1, $zero, Loop //exit if the first num is 0
	
Exit:
	halt
