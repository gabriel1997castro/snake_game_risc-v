##################################################################
#  Programa de exemplo de uso de frames no Bitmap Display Tool   #
#  ISC Set 2019			  			         #
#  Marcus Vinicius Lamar		  		         #
##################################################################
#
# Use o programa paint.net (baixar da internet) para gerar o arquivo .bmp de imagem 320x240 e 24 bits/pixel 
# para então usar o programa bmp2isc.exe para gerar o arquivo .data correspondente para colocar no include
#
# Abra duas janelas do Bitmap, uma com frame 0 e outra com a frame 1

#.data
#.include "isc.data"

.text

PrintLose:	
	li t1,0xFF100000# endereco inicial da Memoria VGA - Frame 1
	li t2,0xFF112C00	# endereco final 
	li t3, 1		# Frame 1
	li t4, 0xFF200604
	sw t3, (t4)
	la s1,CapaGameOver	# endereço dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
LoopGameOver: 	beq t1,t2,FimGameOver	# Se for o último endereço então sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi s1,s1,4
	j LoopGameOver		# volta a verificar
FimGameOver:
	ret