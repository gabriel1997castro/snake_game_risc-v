#.data
#NUM_MUS_PERDEU: .word 5
#NOTAS_PERDEU: 63,800,67,800,70,600,81,500,76,1000 

.text

MusicaPerdeu:

addi sp, sp, -16
sw a2, 0(sp)
sw a3, 4(sp)
sw s0, 8(sp)
sw s1, 12(sp)

	li a0,40		# define a nota
	li a1,1500		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	
	la s0,NUM_MUS_PERDEU		# define o endereço do número de notas
	lw s1,0(s0)		# le o numero de notas
	la s0,NOTAS_PERDEU		# define o endereço das notas
	li t0,0			# zera o contador de notas
	#li a2,68		# define o instrumento
	li a2,0		# define o instrumento
	li a3,70		# define o volume

LOOPSOUND:	beq t0,s1, FIMSOUND	# contador chegou no final? então  vá para FIM
		lw a0,0(s0)		# le o valor da nota
		lw a1,4(s0)		# le a duracao da nota
		li a7,31		# define a chamada de syscall
		ecall			# toca a nota
		#mv a0,a1		# passa a duração da nota para a pausa
		#li a7,32		# define a chamada de syscal 
		#ecall			# realiza uma pausa de a0 ms
		addi s0,s0,8		# incrementa para o endereço da próxima nota
		addi t0,t0,1		# incrementa o contador de notas
		j LOOPSOUND			# volta ao loop
	
FIMSOUND:	
	#li a7,10		# define o syscall Exit
	#ecall			# exit

lw a2, 0(sp)
lw a3, 4(sp)
lw s0, 8(sp)
lw s1, 12(sp)
addi sp, sp, 16

ret
