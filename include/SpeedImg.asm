.text

PrintSpeedImg:
	addi sp, sp, -4
	sw s8, (sp)	
	li t1,0xFF0000C8	###########################################################3# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF00010C  # endereco final da primeira linha 
	li t4,0xFF00254C  # endere�o do final da imagem
	la s8,SpeedImg		# endere�o dos dados da tela na memoria
	addi s8,s8,8		# primeiro pixels depois das informa��es de nlin ncol
	
LoopSpeedImg: beq t1, t4, FinishSpeedImg
	  bne t1, t2, NFLineSpeed	#branch se a linha nao tiver chegado no final
	  	addi t1, t1, 0x0FC
	  	addi t2, t2, 0x140
	  NFLineSpeed:
	  	lw t3, 0(s8)
	  	sw t3, 0(t1)
	  	addi t1, t1, 4
	  	addi s8, s8, 4
	  	j LoopScoreImg

FinishSpeedImg:	
	lw s8, (sp)	
	addi sp, sp, 4
	ret
