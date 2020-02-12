
# .text

# PrintLose:	
# 	li t1,0xFF100000# endereco inicial da Memoria VGA - Frame 1
# 	li t2,0xFF112C00	# endereco final 
# 	li t5, 1		# Frame 1
# 	li t4, 0xFF200604
# 	la s8,CapaGameOver	# endere�o dos dados da tela na memoria
# 	addi s8,s8,8		# primeiro pixels depois das informa��es de nlin ncol
# LoopGameOver: 	beq t1,t2,FimGameOver	# Se for o �ltimo endere�o ent�o sai do loop
# 	lw t3,0(s8)		# le um conjunto de 4 pixels : word
# 	sw t3,0(t1)		# escreve a word na mem�ria VGA
# 	addi t1,t1,4		# soma 4 ao endere�o
# 	addi s8,s8,4
# 	j LoopGameOver		# volta a verificar
# FimGameOver:
# 	sw t5, (t4)
# 	ret

# #.data

# #.include "ScoreImagem.data"

.text
#la tp,exceptionHandling	# carrega em tp o endere�o base das rotinas do sistema ECALL
#csrw tp,utvec 		# seta utvec para o endere�o tp
#csrsi ustatus,1 	# seta o bit de habilita��o de interrup��o em ustatus (reg 0)

PrintLose:
	li a0, 0x0000
	li a1, 1
	li a7, 148
	ecall
	li t1,0xFF1096DC	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF109740  # endereco final da primeira linha 
	li t4,0xFF111300  # endere�o do final da imagem
	li t5, 1		# Frame 1
	li t6, 0xFF200604
	la s8,CapaGameOver		# endere�o dos dados da tela na memoria
	addi s8,s8,8		# primeiro pixels depois das informa��es de nlin ncol
	
LoopGameOver: beq t1, t4, FimGameOver
	  bne t1, t2, NFLine	#branch se a linha nao tiver chegado no final
	  	addi t1, t1, 0x0DC
	  	addi t2, t2, 0x140
	  NFLine:
	  	lw t3, 0(s8)
	  	sw t3, 0(t1)
	  	addi t1, t1, 4
	  	addi s8, s8, 4
	  	j LoopGameOver

FimGameOver:
	li a7,104
	la a0,gameOverString
	li a1,130
	li a2,100
	li a3,0x00FF
	li a4,1
	ecall
	sw t5, (t6)	#Muda de frame
	ret

#	li a7,10		# syscall de exit
#	ecall
#.include "SYSTEMv17b.s"
