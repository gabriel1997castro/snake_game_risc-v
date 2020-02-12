.text
# s4 vetor cobra 
right:	addi sp, sp, -20	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)
	
	li s1, 0	# Contador inicia em 0
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00010000 # valor um na coordenada x
	add a0, a0, t0 	# adiciona 1 a cordenada x da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca
	
	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal PontoDireita
	
	jal VerificaCobra
	beq s5, s2, Grow	
		
	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0xf0f0f0	# cor de fundo
	jal PontoDireita 	# apaga rabo da cobra
	
	addi s0, s0, -4 # faz o loop n?o pegar valores de endereco indevido
	jal directionLoop

########################################################################################################################
down:	addi sp, sp, -20	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)

	li s1, 0	# Contador inicia em 0
	
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00000001 # valor um na coordenada y
	add a0, a0, t0 	# adiciona 1 a cordenada y da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca
	
	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal PontoBaixo

	jal VerificaCobra
	beq s5, s2, Grow

	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0xf0f0f0	# cor de fundo
	jal PontoBaixo 	# apaga rabo da cobra
	
	addi s0, s0, -4 # faz o loop n?o pegar valores de endereco indevido
	jal directionLoop

########################################################################################################################
up:	addi sp, sp, -20	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)

	li s1, 0	# Contador inicia em 0
	
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00000001 # valor um na coordenada y
	sub a0, a0, t0 	# subtrai 1 a cordenada y da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca
	
	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal PontoSobe
	
	jal VerificaCobra
	beq s5, s2, Grow

	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0xf0f0f0	# cor de fundo
	jal PontoSobe	# apaga rabo da cobra
	
	addi s0, s0, -4 # faz o loop n?o pegar valores de endereco indevido
	jal directionLoop

########################################################################################################################
left:	addi sp, sp, -20	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)

	li s1, 0	# Contador inicia em 0
	
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00010000 # valor um na coordenada y
	sub a0, a0, t0 	# subtrai 1 a cordenada y da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca
	
	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal PontoEsquerda
	
	jal VerificaCobra
	beq s5, s2, Grow
	
	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0xf0f0f0	# cor de fundo
	jal PontoEsquerda 	# apaga rabo da cobra
	
	addi s0, s0, -4 # faz o loop n?o pegar valores de endereco indevido
	jal directionLoop

###########################################################################################################
directionLoop:	beq s0, s1, endDirectionLoop
		addi s1, s1, 8
		add a0, s4, s1 # endereco de cada ponto
		addi a1, a0, -4
		lw a0, (a0)
		sw a0, (a1)
		addi s1, s1, -4
		j directionLoop
		
endDirectionLoop:	
			#li s6, 250
			jal Sleep
			sw s2, (s3)
			lw ra, 0(sp)
			lw s0, 4(sp)
			lw s1, 8(sp)
			lw s2, 12(sp)
			lw s3, 16(sp)
			addi sp, sp, 20
			ret	

###########################################################################################################
verificaDireita:
	addi sp, sp, -8	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	jal pegaCabeca
	srli t3, t0, 16 # pega x
	li t1, 0x00000025 # borda direira
	
	bge t3, t1, R1
	blt t3, t1, R2
	R1 : jal LOSE
	R2:	lw ra, 0(sp)
		lw s0, 4(sp)
		addi sp, sp, 8
		ret

###########################################################################################################
verificaEsquerda:
	addi sp, sp, -8	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	jal pegaCabeca
	srli t3, t0, 16 # pega x
	li t1, 0x00000002 # borda esquerda
	
	ble t3, t1, L1
	bgt t3, t1, L2
	L1 : jal LOSE
	L2:	lw ra, 0(sp)
		lw s0, 4(sp)
		addi sp, sp, 8
		ret
###########################################################################################################

verificaAcima:
	addi sp, sp, -8	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	jal pegaCabeca
	li t1, 0x0000FFFF
	and t3, t0, t1
	li t1, 0x00000005 # borda de cima
	
	ble t3, t1, U1
	bgt t3, t1, U2
	U1 : jal LOSE
	U2:	lw ra, 0(sp)
		lw s0, 4(sp)
		addi sp, sp, 8
		ret

###########################################################################################################

verificaAbaixo:
	addi sp, sp, -8	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	jal pegaCabeca
	li t1, 0x0000FFFF
	and t3, t0, t1
	li t1, 0x0000001B # borda de baixo
	
	bge t3, t1, D1
	blt t3, t1, D2
	D1 : jal LOSE
	D2:	lw ra, 0(sp)
		lw s0, 4(sp)
		addi sp, sp, 8
		ret	
###########################################################################################################

pegaCabeca:
	addi sp, sp, -4
	sw s0, (sp)
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add t0, s4, s0 	# pega o endereco da cabeca da cobra
	lw t0, (t0) 	# Carrega a coordenada
	sw s0, (sp)
	addi sp, sp, 4
	ret

###########################################################################################################
Grow:	jal MusicaComeu
	addi s7, s7 , 7
	li t0, 50
	blt t0, s6, Harder
	ContinueGrow: jal Score
	jal Speed
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	addi s0, s0, 1
	sw s0, 0(s4) 	# Guarda novo tamanho
	
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	sw s2, 0(a0)	# Guarda nova cabe�a
	j FinishAfterGrow

###########################################################################################################
FinishAfterGrow:
	#li s6, 250
	jal Sleep
	jal Frutinha
	addi s5, a0, 0 # Endere�o da nova frutinha
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	lw s3, 16(sp)
	addi sp, sp, 20
	ret	
	
###########################################################################################################
VerificaCobra: #Recebe em s2 coordenada da pr�xima cabeca
	
	addi sp, sp, -16	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s4, 8(sp)
	sw s5, 12(sp)
	
	addi s0, zero, 0 	# Contador
	addi t1, zero, 0 	# Contador por endereco
	lw s5, 0(s4) 		# Tamanho da cobra
VCL:	beq s0, s5, FimVerificaCobra
	addi t1, t1, 4	# Proximo endereco da cobra
	add t2, t1, s4	# Endereco offset + multiplo de 4 
	lw t2, (t2)	
	beq s2, t2, LOSE
	addi s0, s0, 1
	j VCL

###########################################################################################################
FimVerificaCobra:
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s4, 8(sp)
	lw s5, 12(sp)
	addi sp, sp, 16
	ret
###########################################################################################################
Harder:
addi s6, s6, -15
addi s9, s9, 1
j ContinueGrow