#################################################
#  Programa de exemplo para Polling do teclado  #
#  usando o Keyboard Display MMIO Tool		#
#  ISC Abr 2018				      	#
#  Marcus Vinicius			      	#
#################################################
# escolha e descomente um dos dois jals no programa 
#
.text

# Polling do teclado e echo na tela
	li s0,0			# zera o contador
CONTA:  addi s0,s0,1		# incrementa o contador
	jal KEY1		# le o teclado	blocking
#	jal KEY2       		# le o teclado 	non-blocking
	j CONTA			# volta ao loop

### Espera o usuário pressionar uma tecla
KEY1: 	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
LOOP: 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP		# não tem tecla pressionada então volta ao loop
   	lw t2,4(t1)			# le o valor da tecla
  	sw t2,12(t1)  			# escreve a tecla pressionada no display
	ret				# retorna

### Apenas verifica se há tecla pressionada
KEY2:	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM   	   	# Se não há tecla pressionada então vai para FIM
  	lw t2,4(t1)  			# le o valor da tecla tecla
	sw t2,12(t1)  			# escreve a tecla pressionada no display
FIM:	ret				# retorna
