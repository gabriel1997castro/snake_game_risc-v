.text

#la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
#csrw tp,utvec 		# seta utvec para o endereço tp
#csrsi ustatus,1 		# seta o bit de habilitação de interrupção em ustatus (reg 0)

	#li s6, 10000	#####

Sleep:	
	addi a0, s6, 0 #Recebe s6 como argumento inicial, contendo o tempo que se quer pausar
	#li a0,1000   # 1 segundo
	li a7,132
	ecall
	#li a7,101
	#li a1,120
	#li a2,120
	#li a3,0x0038
	#li a4,0
	#ecall
	#bne t0,zero,LOOPHMS
	
#li a7, 10
#ecall	
	ret
	
#.include "SYSTEMv17b.s"
