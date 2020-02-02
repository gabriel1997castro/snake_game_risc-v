.text
# s4 vetor cobra 
right:	addi sp, sp, -20	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)

	li s1, 0	# Contador inicia em 0
	
	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0x00228B22	# cor de fundo
	jal Ponto 	# apaga rabo da cobra
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00010000 # valor um na coordenada x
	add a0, a0, t0 	# adiciona 1 a cordenada x da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca
	jal VerificaBordaDireita
	
	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal Ponto
	
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
	
	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0x00228B22	# cor de fundo
	jal Ponto 	# apaga rabo da cobra
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00000001 # valor um na coordenada y
	add a0, a0, t0 	# adiciona 1 a cordenada y da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca
	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal Ponto
	
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
	
	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0x00228B22	# cor de fundo
	jal Ponto 	# apaga rabo da cobra
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00000001 # valor um na coordenada y
	sub a0, a0, t0 	# subtrai 1 a cordenada y da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca
	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal Ponto
	
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
	
	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0x00228B22	# cor de fundo
	jal Ponto 	# apaga rabo da cobra
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00010000 # valor um na coordenada y
	sub a0, a0, t0 	# subtrai 1 a cordenada y da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca
	jal VerificaBordaEsquerda
	
	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal Ponto
	
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
		
endDirectionLoop:	sw s2, (s3)
			lw ra, 0(sp)
			lw s0, 4(sp)
			lw s1, 8(sp)
			lw s2, 12(sp)
			lw s3, 16(sp)
			addi sp, sp, 16
			ret	

VerificaBordaDireita:
	add t0, s2, zero # Carrega ponto a direita da cabe�a da cobra
	srli t3, t0, 16 # pega x
	li t1, 0x00000025 # borda direira
	bge t3, t1, LOSE
	ret
	
VerificaBordaEsquerda:
	add t0, s2, zero # Carrega ponto a esquerda da cabe�a da cobra
	srli t3, t0, 16 # pega x
	li t1, 0x00000002 # borda direira
	ble t3, t1, LOSE
	ret