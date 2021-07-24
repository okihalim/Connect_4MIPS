.data
	board: .space 42
	prompt: .asciiz "\n Enter the collumn you wish to drop in (1-7): " #Error messages and prompts are written here
	newline: .asciiz "\n"
	message1: .asciiz "\n Starting a new game. \n"
	prompt2: .asciiz "\n Enter 1 for new game against cpu, 2 for against human, enter 0 to quit: "
	finished: .asciiz "\n Thanks for playing"
	win1: .asciiz "\n The X's win! "
	win2: .asciiz "\n The O's win! "
	Oturn: .asciiz "\n it is the O's turn \n"
	Xturn: .asciiz "\n it is the X's turn \n"
	invalid1: .asciiz "\n That is not a valid collumn"
	invalid2: .asciiz "\n That collumn is full"
	win3: .asciiz "\n There was a tie, board is full"
	pi1: .asciiz "in here 1\n"
	pi2: .asciiz "in here 2\n"
	
.include "mips5.asm"
.include "checkwinner.asm"
.text

	
	
	jal clearboard #jump to clear board function in mips5 file
	
	
	
printboard:
	li $s2, 0 #Reset counters just in case
	li $s3, 0
	li $v0, 11 #We gonna just be printing Chars. Lots of em
	printloop:
	beq $s2, 42, endprint
	li $a0, '|'
	syscall
	lb $a0, board($s2)
	bne $a0, 0, notnull #Print charachter, unless null, then print underscore.
	li $a0, '_'
	notnull:
	syscall
	addi $s2, $s2, 1 #increment counters
	addi $s3, $s3, 1
	bne $s3, 7, printloop #if we reach the end of the row cap and new line
	li $s3, 0
	li $a0, '|'
	syscall
	li $a0, '\n'
	syscall
	j printloop
endprint:
	li $s2, 0 #/// Keep registers predictable
	li $s3, 0


	jal winnercheck #jump to winner check function in checkwinner file
	
increment:
	beq $s5, 42, tie
	addi $s3, $s3, 1
	addi $s2, $s2, 1
	bne $s3, 7, winnercheck
	li $s3, 0
	j winnercheck
	
endcheck:
	beq $s4, 0, set1
	li $s4, 0
	j player1
	set1:
	li $s4, 1
	j player2
	
	player1:
		li $v0, 4
		la $a0, Xturn
		syscall
		li $v0, 4
		la $a0, prompt
		syscall
		li $v0, 5
		syscall
		bgt $v0, 7, invalid
		blt $v0, 0, invalid
		j Aplace
		invalid:
			li $v0, 4
			la $a0, invalid1
			syscall
			j player1
		Aplace:
		li $t0, 0
		li $t1, 0
		addi $t0, $v0, -1
		addi $t0, $t0, 35
		lb $t1, board($t0)
		beq $t1, 0, Aplacer
		addi $t0, $t0, -7
		li $t1, 0
		lb $t1, board($t0)
		beq $t1, 0, Aplacer
		addi $t0, $t0, -7
		li $t1, 0
		lb $t1, board($t0)
		beq $t1, 0, Aplacer
		addi $t0, $t0, -7
		li $t1, 0
		lb $t1, board($t0)
		beq $t1, 0, Aplacer
		addi $t0, $t0, -7
		li $t1, 0
		lb $t1, board($t0)
		beq $t1, 0, Aplacer
		addi $t0, $t0, -7
		li $t1, 0
		lb $t1, board($t0)
		beq $t1, 0, Aplacer
		#If no spot is free, say that collumn is full.
		li $v0, 4
		la $a0, invalid2
		syscall
		j player1
		
		Aplacer:
		li $t3, 'X'
		sb $t3, board($t0)
			
	addi $s5, $s5, 1
	j printboard
	
	player2:
		li $v0, 4
		la $a0, Oturn
		syscall
		beq $s6, 1, computer
	
		human:
		li $v0, 4
		la $a0, prompt
		syscall
		li $v0, 5
		syscall
		bgt $v0, 7, invalidr
		blt $v0, 0, invalidr
		j Bplace
		invalidr:
			li $v0, 4
			la $a0, invalid1
			syscall
			j player2
	
		computer:
			li $a1, 7
			li $v0, 42
			syscall
			move $v0, $a0
		
		Bplace:
		li $t0, 0
		li $t1, 0
		addi $t0, $v0, -1
		addi $t0, $t0, 35
		lb $t1, board($t0)
		beq $t1, 0, Bplacer
		addi $t0, $t0, -7
		li $t1, 0
		lb $t1, board($t0)
		beq $t1, 0, Bplacer
		addi $t0, $t0, -7
		li $t1, 0
		lb $t1, board($t0)
		beq $t1, 0, Bplacer
		addi $t0, $t0, -7
		li $t1, 0
		lb $t1, board($t0)
		beq $t1, 0, Bplacer
		addi $t0, $t0, -7
		li $t1, 0
		lb $t1, board($t0)
		beq $t1, 0, Bplacer
		addi $t0, $t0, -7
		li $t1, 0
		lb $t1, board($t0)
		beq $t1, 0, Bplacer
		beq $s6, 1, player2 #no error message if the CPU did a dumb
		li $v0, 4
		la $a0, invalid2 #Yes error message if it was a human.
		syscall
		j player2
		Bplacer:
		li $t3, 'O'
		sb $t3, board($t0)
	
	addi $s5, $s5, 1
	j printboard

end: 
	li $v0, 4
	la $a0, finished
	syscall
	li $v0, 10
	syscall
won:
	li $v0, 4
	beq $s4, 1, otherwin
	la $a0, win1
	syscall
	j clearboard
	li $a0, 67
li $a1 154
li $a2 0
li $a3 100
li $v0 33
syscall
li $a0, 67
li $a1 154
li $a2 0
li $a3 100
syscall
li $a0, 67
li $a1 154
li $a2 0
li $a3 100
syscall
li $a0, 66
li $a1 462
li $a2 0
li $a3 100
syscall
li $a0, 62
li $a1 462
li $a2 0
li $a3 100
syscall
li $a0, 64
li $a1 462
li $a2 0
li $a3 100
syscall
li $a0, 66
li $a1 308
li $a2 0
li $a3 100
syscall
li $a0, 64
li $a1 154
li $a2 0
li $a3 100
syscall
li $a0, 66
li $a1 1385
li $a2 0
li $a3 100
syscall
#462 per beat
#$a0 pitch/note
#$a1 time in ms
#$a2 instrument
#welll, its some thing

	otherwin:
	la $a0, win2
	syscall
	j clearboard
tie:
	li $v0, 4
	la $a0, win3
	syscall
	j clearboard



