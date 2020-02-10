
.text

PrintHomeImg:	
	li t1,0xFF100000# endereco inicial da Memoria VGA - Frame 1
	li t2,0xFF112C00	# endereco final 
	li t5, 1		# Frame 1
	li t4, 0xFF200604
	la s8,HomeImg	# endere�o dos dados da tela na memoria
	addi s8,s8,8		# primeiro pixels depois das informa��es de nlin ncol
LoopHomeImg: 	beq t1,t2,EndHomeImg	# Se for o �ltimo endere�o ent�o sai do loop
	lw t3,0(s8)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	addi s8,s8,4
	j LoopHomeImg		# volta a verificar
EndHomeImg:
	sw t5, (t4) #Muda Frame
	ret
