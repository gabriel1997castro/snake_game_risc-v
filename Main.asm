.data
.data
NUM_MUS_PERDEU: .word 5
NOTAS_PERDEU: 63,800,67,800,70,600,81,500,76,1000 
cobra: 	.align 2 #Align in words
	.space 1024
	
.text

la tp,exceptionHandling	# carrega em tp o endere�o base das rotinas do sistema ECALL
csrw tp,utvec 		# seta utvec para o endere�o tp
csrsi ustatus,1 	# seta o bit de habilita��o de interrup��o em ustatus (reg 0)

li s0, 0x00000061 # Valor da tecla a
li s1, 0x00000064 # Valor da tecla d
li s2, 0x00000073 # Valor da letra s
li s3, 0x00000077 # Valor da letra w

iniciaCobra:
la s4, cobra 		#endereco do vetor cobra
li t0, 3 		#tamanho inicial
sw t0, 0(s4)		#guarda tamanho inicial da cobra no vetor
li t0, 0x0014000F 	#local inicial da cabeca
sw t0, 4(s4)		#coloca a cabeca no vetor
li t0, 0x0015000F
sw t0, 8(s4)		#coloca a cabeca no vetor
li t0, 0x0016000F
sw t0, 12(s4)		#coloca a cabeca no vetor

jal TelaFundo
jal DesenhaCobra


li a3, 2 #tamanho da cobra
li a1, 0x0015000F
li a2, 0x0014000F

KEYBOARD: 	jal KEY2
		beq s11, s1, R # compara se o valor lido do teclado eh 'd'
		beq s11, s3, U # compara se o valor lido do teclado eh 'w'
		beq s11, s2, D # compara se o valor lido do teclado eh 's'
		beq s11, s0, L # compara se o valor lido do teclado eh 'a'
		j KEYBOARD

R: 	jal verificaDireita
	beq s11, s1, RIGHT # compara se o valor lido do teclado eh 'd'
	j KEYBOARD
L:	jal verificaEsquerda
	beq s11, s0, LEFT # compara se o valor lido do teclado eh 'd'
	j KEYBOARD
U:	jal verificaAcima
	beq s11, s3, UP # compara se o valor lido do teclado eh 'd'
	j KEYBOARD
D:	jal verificaAbaixo
	beq s11, s2, DOWN # compara se o valor lido do teclado eh 'd'
	j KEYBOARD
RIGHT:		jal right
		j KEYBOARD
UP:		jal up
		j KEYBOARD
DOWN:		jal down
		j KEYBOARD
LEFT:		jal left
		j KEYBOARD		
FIMSNAKE:
#Finaliza o programa
li a7, 10
ecall

.include "SYSTEMv17b.s"
.include "TelaFundo.asm"
.include "Ponto.asm"
.include "key.asm"
.include "Directions.asm"
.include "Lose.asm"
.include "DesenhaCobra.asm"
.include "MusicaPerdeu.s"
