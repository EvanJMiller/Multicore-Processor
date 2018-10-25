//Mult procedure
	
	org 0x0000 //start of the program

	ori $sp,$zero,0xfffc  //store the starting point of the stack

	ori $s0, $zero, 0x0004
	ori $s1, $zero, 0x0005
	ori $s2, $zero, 0x0005
	ori $s3, $zero, 0x0002
	
	ori $s4, $zero, 0x0001 //saved as a const

	push $s0
	push $s1
	push $s2
	push $s3
	
	jal multiply
	pop $s3
	halt

multiply:
	pop $s3
	//sub $s3, $s3, $s4
outerLoop:	
	pop $t1
	pop $t2
	ori $t0, $zero, 0
innerLoop:	
	add $t0, $t0, $t1 
	sub $t2, $t2, $s4
	bne $t2, $zero, innerLoop

innerDone:	
	sub $s3, $s3, $s4 //decrement
	
	push $t0 //push the accumulator
	bne $s3, $zero, outerLoop
Exit:
	halt

