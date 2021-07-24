
#/// We check winners right here so that formatting is easy- if a winning move was performed, the board will be right above the win message.
#//Ez pz.
.data

.text

.globl winnercheck
winnercheck:
	#/////First, we make a loop. Winner check gets attempted on every spot every turn.
	beq $s2, 42, endcheck
	#///If the row is greater than 2 (0 indexed) three of the 4 checks don't matter.
	lb $s1, board($s2)
	beq $s1, 0, increment
	bgt $s2, 20, rightcheck
	downcheck:
		li $t0, 0
		li $t1, 0
		addi $t1, $s2, 7
		lb $t0, board($t1)
		bne $t0, $s1, leftdiag
		li $t0, 0 
		addi $t1, $t1, 7
		lb $t0, board($t1)
		bne $t0, $s1, leftdiag
		li $t0, 0
		addi $t1, $t1, 7
		lb $t0, board($t1)
		bne $t0, $s1, leftdiag
		j won
	leftdiag:
	blt $s3, 3 rightdiag 
		li $t0, 0
		li $t1, 0
		addi $t1, $s2, 6
		lb $t0, board($t1)
		bne $t0, $s1, rightdiag
		li $t0, 0 
		addi $t1, $t1, 6
		lb $t0, board($t1)
		bne $t0, $s1, rightdiag
		li $t0, 0
		addi $t1, $t1, 6
		lb $t0, board($t1)
		bne $t0, $s1, rightdiag
		j won
		
	rightdiag:
	bgt $s3, 3, rightcheck
		li $t0, 0
		li $t1, 0
		addi $t1, $s2, 8
		lb $t0, board($t1)
		bne $t0, $s1, rightcheck
		li $t0, 0 
		addi $t1, $t1, 8
		lb $t0, board($t1)
		bne $t0, $s1, rightcheck
		li $t0, 0
		addi $t1, $t1, 8
		lb $t0, board($t1)
		bne $t0, $s1, rightcheck
		j won
	#//////Anything below the 4th layer from the bottom can't be a chain that goes downwards
	rightcheck:
	bgt $s3, 3, increment
		li $t0, 0
		li $t1, 0
		addi $t1, $s2, 1
		lb $t0, board($t1)
		bne $t0, $s1, increment
		li $t0, 0 
		addi $t1, $t1, 1
		lb $t0, board($t1)
		bne $t0, $s1, increment
		li $t0, 0
		addi $t1, $t1, 1
		lb $t0, board($t1)
		bne $t0, $s1, increment
		j won