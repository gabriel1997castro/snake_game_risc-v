.text
# Passar cabeca, calda, e tamanho:
# a3 tamanho
# a1 cabeca
# a2 calda


left:	
	addi t0, ra, 0 # guarda retorno
	addi t1, a1, 0 # guarda cabeca
	srli a0, a1, 16 #
	addi a0, a0, 1 #guarda valor da cabeca + 1 em x para mover a cobra 
	slli a0, a0, 16
	li t2, 0x0000FFFF
	and t1, t1, t2
	add a0, a0, t1
	li a1, 0x0000
	jal Ponto
	
	addi t1, a2, 0 # guarda calda
	srli a0, a2, 16 #
	addi a0, a2, -1 #guarda valor da calda - 1 para mover a cobra
	li a1, 0x00228B22 #valor da cor para apagar o ponto quando move
	jal Ponto
	addi ra, t0, 0 # pega retorno para main
	ret