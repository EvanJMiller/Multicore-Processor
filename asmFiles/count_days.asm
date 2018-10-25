//Evan Miller
//mill1576@purdue.edu

	org 0x0000
	ori $29, $0, 0xfffc      //Set $29 to FFFC

	ori $2, $0, 2000        //Year 2000
	ori $3, $0, 6            //Day
	ori $4, $0, 1            //Month

	ori $7, $0, 0            //Month days
	ori $8, $0, 0            //Year days
	ori $9, $0, 1            //Register with value of 1

	ori $10, $0, 0           //Set day accumilator to 0
	ori $11, $0, 30          //Number of days in a month
	ori $12, $0, 365         //Number of days in a year
	ori $5, $0, 2018         //Year

	subu $25, $4, $9	 //store for later
	subu $4, $4, $9          //Month for calc

	subu $26, $5, $2
	subu $5, $5, $2          //Year for calc

LoopMonths:
	beq $4, $0, LoopYears
	addu $7, $7, $11      //Add 30 to the day accumilator
	subu $4, $4, $9        //Decriment second value by 1
	bne $4, $0, LoopMonths     //Loop back to multiply if second value is not 0
LoopYears:
	beq $5, $0, end
	addu $8, $8, $12      //Add 365 to the year accumilator
	subu $5, $5, $9        //Decrement second value by 1
	bne $5, $0, LoopYears      //Loop back to multiply if second value is not 0
end:

	addu $10, $3, $7         //Add days to month days into the day accumilator
	addu $10, $10, $8        //Add year days to day accumilator into the day accumilator
	push $10                 //Push final accumilation onto stack

	halt



