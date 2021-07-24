
#ffff

	
.text

.globl clearboard
clearboard:

	
	#////////////Ask player to continue////////////////////////////////////
	li $v0, 4
	la $a0, prompt2
	syscall
	#/////////Read the int in////////////////
	li $v0, 5
	syscall
	beq $v0, 0, end
	beq $v0, 1, cpu
	li $s6, 0
	j there
	cpu:
	li $s6, 1
	there:
	
	#////////Otherwise we start a new game///////////
	li $s5, 0 #move counter. Game auto ends in a tie if move 42 is reached with no winner.
	#//////// We reset the important registers///////
	li $s0, 0 #This is the win ticker, will be explained in win section
	li $s1, 0 #This is the char holder
	li $s2, 0 #This is the print loop counter.
	li $s3, 0 #This is the smaller row counter for printing
	li $s4, 0 # This is what checks who's turn it is

	#////here we empty out the board by setting everything to null, fun!
		li $t0, 0
	clearloop:
		sb $zero, board($t0)
		addi $t0, $t0, 1
		bne $t0, 42, clearloop
		li $t0, 0
		
	#//// board should be empty.////////////
j printboard
	