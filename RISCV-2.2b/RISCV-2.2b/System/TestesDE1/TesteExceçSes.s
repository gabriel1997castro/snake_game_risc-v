# Usar self-modifying code

.text 
la 	tp, exceptionHandling		# carrega em t6 o endereço base das rotinas do sistema ECALL
csrrsi 	zero, 0, 1 		# seta o bit de habilitação de interrupção em ustatus (reg 0)
csrrw 	zero, 5, tp 		# seta utvec (reg 5) para o endereço tp


li 	a7, 41 	# num aleatorio em a0
ecall  			# teste da causa 8 = enviroment call

li 	t0, 8
remu 	a0, a0, t0 	# a0 = a0 mod 8


li 	a0,5


li 	t0, 0
beq 	a0, t0, Case0

li 	t0, 1
beq 	a0, t0, Case1

li 	t0, 2
beq	a0, t0, Case2

li 	t0, 4
beq 	a0, t0, Case4

li 	t0, 5
beq 	a0, t0, Case5

li 	t0, 6
beq 	a0, t0, Case6

li 	t0, 7
beq 	a0, t0, Case7

CaseD: 	li 	a7, 10
	ecall

Case0: # Instruction address misaligned
li 	ra, 0x0000ffff
jr 	ra
j CaseD

Case1: #  Instruction access fault 
li 	ra, 0x0000ff00
jr 	ra
j CaseD

Case2: # Ilegal Instruction 
la 	t0, Inst
sw 	zero, 0(t0)
nop
Inst: 	nop   # local da instrução não reconhecida
j CaseD

Case4: # Load address misaligned 
li 	t0, 0xff00001
lw 	s0, 0(t0)
j CaseD

Case5: # Load access fault 
li 	t0, 0xaaaa0000
lw 	s0, 0(t0)
j CaseD

Case6: # Store address misaligned 
li 	t0, 0xff00001
sw 	s0, 0(t0)
j CaseD

Case7: # Store access fault 
li 	t0, 0xaaaa0000
sw 	s0, 0(t0)
j CaseD



.include "SYSTEMv15.s"
