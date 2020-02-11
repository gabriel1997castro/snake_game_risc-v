.data
NUM_MUS_PERDEU: .word 5
NOTAS_PERDEU: 6,800,67,800,70,600,81,500,76,1000 
cobra: 	.align 2 #Align in words
	.space 1024
.include "include/CapaGameOver.data"
.include "include/HomeImg.data"
.include "include/ScoreImagem.data"
.include "include/SpeedImg.data"
gameOverString: 	.string "GAME OVER"

.text

la tp,exceptionHandling	# carrega em tp o endere�o base das rotinas do sistema ECALL
csrw tp,utvec 		# seta utvec para o endere�o tp
csrsi ustatus,1 	# seta o bit de habilita��o de interrup��o em ustatus (reg 0)

IniciaJogo:

li s0, 0x00000061 # Valor da tecla a
li s1, 0x00000064 # Valor da tecla d
li s2, 0x00000073 # Valor da letra s
li s3, 0x00000077 # Valor da letra w
li s6, 250
li s7, 0		  # Pontuação
li s9, 5		  # Pontuação
li s11, 0x00000064


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

jal PrintHomeImg
li s6, 3000
jal Sleep
li t3, 0		# Frame 1
li t4, 0xFF200604
sw t3, (t4)
jal TelaFundo
jal ScoreImg
jal PrintSpeedImg
jal DesenhaCobra
jal Frutinha
addi s5, a0, 0 # Coordenada da fruta

li s6, 250 #Tempo
li a3, 2 #tamanho da cobra
li a1, 0x0015000F
li a2, 0x0014000F
jal Score
jal Speed

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

.include "include/frutinha.asm"
.include "include/SYSTEMv17b.s"
.include "include/TelaFundo.asm"
.include "include/PontoDireita.asm"
.include "include/PontoEsquerda.asm"
.include "include/PontoBaixo.asm"
.include "include/PontoSobe.asm"
.include "include/key.asm"
.include "include/Directions.asm"
.include "include/Lose.asm"
.include "include/DesenhaCobra.asm"
.include "include/MusicaPerdeu.s"
.include "include/MusicaComeu.s"
.include "include/TimeSleep.asm"
.include "include/Score.asm"
.include "include/Speed.asm"
.include "include/PrintCapaGameOver.s"
.include "include/ScoreImg.asm"
.include "include/SpeedImg.asm"
.include "include/homeImg.asm"
