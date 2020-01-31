####################################################
#  Programa de exemplo de interrupçao do teclado   #
#  usando o Keyboard Display MMIO Tool		   #
#  ISC Set 2019				           #
#  Marcus Vinicius			           #
####################################################

.text
# programa do usuário

 	la tp,KDInterrupt	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
 	csrrw zero,5,tp 	# seta utvec (reg 5) para o endereço tp
 	csrrsi zero,0,1 	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	li tp,0x100
 	csrrw zero,4,tp		# habilita a interrupção do usuário

 	li t1,0xFF200000	# Endereço de controle do KDMMIO
	li t0,0x02		# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)   		# Habilita interrupção do teclado
  
     
	li s0,0			# zera contador
CONTA:	addi s0,s0,1 		# incrementa contador
	j CONTA			# volta ao loop


# rotina de tratamento da interrupção
KDInterrupt:	csrrci zero,0,1 	# clear o bit de habilitação de interrupção global em ustatus (reg 0)

  		lw t2,4(t1)  			# le a tecla
		sw t2,12(t1) 			# escreve no display

		csrrsi zero,0,0x10 	# seta o bit de habilitação de interrupção em ustatus 
		uret			# retorna PC=uepc		
