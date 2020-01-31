.data
msg7:   .string "Clock:"
msg8:   .string "MHz"

.text
 	la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
 	csrrw zero,5,tp 	# seta utvec (reg 5) para o endereço tp
 	csrrsi zero,0,1 	# seta o bit de habilitação de interrupção em ustatus (reg 0)	

	li a0,0x00
	li a7,148
	li a1,0
	ecall

	li t0,0x3fc80000
	fmv.s.x fa0,t0
	j PP

FREQ:  	li a7,104
	la a0,msg7
	li a1,0
	li a2,64
	li a3,0x0038
	li a4,0
	ecall

	# syscall read freq
	jal LEFDIV
	#li a7,46
	#ecall
	
PP:	li a7,102
	li a1,56
	li a2,64
	li a3,0x0038
	li a4,0
	ecall

  	li a7,104
	la a0,msg8
	li a1,184
	li a2,64
	li a3,0x0038
	li a4,0
	ecall

FIM:	j FIM

LEFDIV:		li 	t0, 0xFF200710		# carrega endereco do FDIVIDER
		lw 	a0, 0(t0)		# le a word em t0
		bne 	a0,zero,PULA	 	# se a0=0
		li 	a0, 32			# faz divisor a0=32
PULA:		fcvt.s.w ft1,a0			# converte em float
		li t0,50			# frequencia base = 50MHz
		fcvt.s.w ft0,t0			# converte em float
		fdiv.s fa0,ft0,ft1		# 50/divisor
		ret


.include "../SYSTEMv16a.s"