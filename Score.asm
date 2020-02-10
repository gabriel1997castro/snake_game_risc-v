#.data

.text
#la tp,exceptionHandling	# carrega em tp o endere�o base das rotinas do sistema ECALL
#csrw tp,utvec 		# seta utvec para o endere�o tp
#csrsi ustatus,1 		# seta o bit de habilita��o de interrup��o em ustatus (reg 0)

#addi t0, t0, 20

# syscall print int	
Score: 
	#Fazer o t0 receber o valor da pontua��o
	
	li a7,101
	mv a0,s6
	li a1,15
	li a2,20
	li a3,0x00FF
	li a4,0
	ecall
	
	li a7, 10
ecall
	ret
#.include "SYSTEMv17b.s"
