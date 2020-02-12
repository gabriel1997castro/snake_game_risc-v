.text

DesenhaCobra:
	addi sp, sp, -16
	sw s4, 0(sp)
	sw s5, 4(sp)
	sw s6, 8(sp)
	sw s10, 12(sp)

	add s10, ra, zero #guarda ra
	lw t0, 0(s4) 	# Carrega tamanho da cobra
	slli s6, t0, 2	# Multiplica por 4
	li s5, 0	# Contador inicia em 0
	#li a1, 0x0000	# cor da cobra
Loop:	beq s5, s6, fimLoop
	addi s5, s5, 4	# incrementa contador
	#slli t2, t1, 2	# multiplica por 4
	add t2, s5, s4 	# guarda endere�o da proxima posicao da cobra
	lw a0, (t2) 	# guarda a proxima posicao
	li a1, 0x0000	# cor da cobra
	jal PontoDireita
	j Loop 
	
fimLoop:	add ra, s10, zero
			lw s4, 0(sp)
			lw s5, 4(sp)
			lw s6, 8(sp)
			lw s10, 12(sp)
			addi sp, sp, 16
			ret
