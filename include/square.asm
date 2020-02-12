
.text

# a0 = coordenada (0x) 
# a1 = cor

#li a0, 0x00600060
#li a1, 0x00FF

#la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
#csrw tp,utvec 		# seta utvec para o endereço tp
#csrsi ustatus,1 	# seta o bit de habilitação de interrupção em ustatus (reg 0)

Ponto:
slli a0, a0, 3 #Converte pontos de 40x30 para 320x240
li t3, 0x0000FFFF
li t4, 0xFFFF0000
li t6, 7
addi t0, a0, 0	# t0 recebe a coordenada
addi t1, a1, 0	# t1 recebe a cor
li t5, 0
and a1, t0, t3	# a0 recebe os 16 primeiros bits (coordenada y0)
and a0, t0, t4	# a1 recebe os 16 menos significativos x0
srli a0, a0, 16 	# 

addi a2, a0, 8
addi a3, a1, 0
addi a4, t1, 0
li a5, 0
li a7, 147
ecall
For:
beq t5, t6, Label
addi a1, a1, 1
addi a2, a0, 8
addi a3, a1, 0
addi a4, t1, 0
addi t5, t5, 1
li a5, 0
li a7, 147
ecall
j For

Label:   
ret

#li a7, 10
#ecall

#.include "SYSTEMv17b.s"
