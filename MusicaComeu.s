.text
MusicaComeu:

addi sp, sp, -8
sw a2, 0(sp)
sw a3, 4(sp)

	li a0,40		# define a nota
	li a1,800		# define a duração da nota em ms
	li a2,120		# define o instrumento
	li a3,127		# define o volume
	li a7,33		# define o syscall
	ecall			# toca a nota
	
	#li a7,10		# define o syscall Exit
	#ecall			# exit

lw a2, 0(sp)
lw a3, 4(sp)
addi sp, sp, 8

ret
