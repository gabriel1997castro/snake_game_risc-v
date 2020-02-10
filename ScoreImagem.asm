#.data

#.include "ScoreImagem.data"

.text
#la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
#csrw tp,utvec 		# seta utvec para o endereço tp
#csrsi ustatus,1 	# seta o bit de habilitação de interrupção em ustatus (reg 0)

#addi t5, s1, 0

ScoreImg:	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF000044  # endereco final da primeira linha 
	li t4,0xFF002484  # endereço do final da imagem
	la s1,ScoreImagem		# endereço dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
	
LoopScoreImg: beq t1, t4, FimScoreImg
	  bne t1, t2, NFLinha	#branch se a linha nao tiver chegado no final
	  	addi t1, t1, 0x0FC
	  	addi t2, t2, 0x140
	  NFLinha:
	  	lw t3, 0(s1)
	  	sw t3, 0(t1)
	  	addi t1, t1, 4
	  	addi s1, s1, 4
	  	j LoopScoreImg

FimScoreImg:	
ret

#	li a7,10		# syscall de exit
#	ecall
#.include "SYSTEMv17b.s"
