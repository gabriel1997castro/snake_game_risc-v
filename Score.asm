#.data

.text
#la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
#csrw tp,utvec 		# seta utvec para o endereço tp
#csrsi ustatus,1 		# seta o bit de habilitação de interrupção em ustatus (reg 0)

#addi t0, t0, 20

# syscall print int	
Score: 
	#Fazer o t0 receber o valor da pontuação
	
	li a7,101
	mv a0,t0
	li a1,15
	li a2,20
	li a3,0x00FF
	li a4,0
	ecall
	
	li a7, 10
ecall
	ret
#.include "SYSTEMv17b.s"
