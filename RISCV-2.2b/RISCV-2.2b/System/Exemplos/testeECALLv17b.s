# Teste dos syscalls 1xx que usam o SYSTEMv15.s
# Conectar o BitMap Display e o KD MMIO para executar
# na DE1-SoC e no Rars deve ter o mesmo comportamento sem alterar nada
# 2019/2


.data
FLOAT: 	.float 	3.14159265659
msg1: 	.string "Organizacao e Arquitetura de Computadores  2019/2"
msg2: 	.string "Digite seu Nome:"
msg3: 	.string "Digite sua Idade:"
msg4: 	.string "Digite seu peso:"
msg5: 	.string "Numero Randomico:"
msg6: 	.string "Tempo do Sistema:"
msg7:   .string "Clock:"
msg8:   .string "MHz"
buffer: .string "                                "

.text
 	la tp,exceptionHandling	# carrega em tp o endere�o base das rotinas do sistema ECALL
 	csrw tp,utvec 		# seta utvec para o endere�o tp
 	csrsi ustatus,1 	# seta o bit de habilita��o de interrup��o em ustatus (reg 0)																																																				
	
	
	jal CLSV
	jal CLSV
	jal CLSV
	ebreak
	jal CLS
	jal PRINTSTR1
	jal INPUTSTR
	jal INPUTINT
	jal INPUTFP
	jal RAND
	jal TIME
	jal FREQ
	jal TOCAR
	jal SLEEP
	jal DRAW
	
	li a7,10
	ecall
				
# CLS Clear Screen
CLS:	li a0,0x00
	li a7,148
	li a1,0
	ecall
	ret
				
# syscall print string
PRINTSTR1: li a7,104
	la a0,msg1
	li a1,0
	li a2,0
	li a3,0x0038
	li a4,0
	ecall
	ret		
	
INPUTSTR: li a7,104
	la a0,msg2
	li a1,0
	li a2,24
	li a3,0x0038
	li a4,0
	ecall
	
# syscall read string
	li a7,108
	la a0,buffer
	li a1,32
	ecall
	
# syscall print string	
	li a7,104
	la a0,buffer
	li a1,144
	li a2,24
	li a3,0x0038
	li a4,0
	ecall
	ret
	
# syscall read int
# syscall print string	
INPUTINT: li a7,104
	la a0,msg3
	li a1,0
	li a2,32
	li a3,0x0038
	li a4,0
	ecall

	# syscall read int
	li a7,105
	ecall
	mv t0,a0

# syscall print int	
PRINTINT: li a7,101
	mv a0,t0
	li a1,152
	li a2,32
	li a3,0x0038
	li a4,0
	ecall
	ret
	
# syscall read float
# syscall print string	
INPUTFP: li t0,0 
	la t1,FLOAT
	flw f0,0(t1)
	fmv.x.s t0,f0
	beq t0,zero,FORAFP  # testa para ver se tem a FPU
  	li a7,104
	la a0,msg4
	li a1,0
	li a2,40
	li a3,0x0038
	li a4,0
	ecall

	li a7,106
	ecall
	
	# syscall print float
	li a7,102
	li a1,144
	li a2,40
	li a3,0x0038
	li a4,0
	ecall

		
FORAFP:	ret
	
# Leitura do divisor de frequencia
# syscall print string	
FREQ: 	li t0,0 
	la t1,FLOAT
	flw f0,0(t1)
	fmv.x.s t0,f0
	beq t0,zero,FORAFREQ  # testa para ver se tem a FPU

  	li a7,104
	la a0,msg7
	li a1,0
	li a2,64
	li a3,0x0038
	li a4,0
	ecall

	# syscall read freq
	li a7,46
	ecall
	
	li a7,102
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

FORAFREQ: ret	
	
	
# Contatos imediatos do terceiro grau
TOCAR:	li a0,62
	li a1,500
	li a2,16
	li a3,127
	li a7,133
	ecall
	li a0,64
	li a1,500
	li a2,16
	li a3,127
	li a7,133
	ecall
	li a0,61
	li a1,500
	li a2,16
	li a3,127
	li a7,133
	ecall
	li a0,50
	li a1,500
	li a2,16
	li a3,127
	li a7,133
	ecall
	li a0,55
	li a1,800
	li a2,16
	li a3,127
	li a7,131
	ecall
	ret
			
# syscall rand
# syscall print string	
RAND:	li a7,104
	la a0,msg5
	li a1,0
	li a2,48
	li a3,0x0038
	li a4,0
	ecall
	# syscall Rand
	li a7,141
	ecall
	# print int em hex
	li a7,134
	li a1,148
	li a2,48
	li a3,0x0038
	li a4,0
	ecall
	ret
		
# syscall time
# syscall print string	
TIME:	li a7,104
	la a0,msg6
	li a1,0
	li a2,56
	li a3,0x0038
	li a4,0
	ecall
	li a7,130
	ecall
	mv t0,a0
	mv t1,a1
	
#print int
	mv a0,t1
	li a7,136	# colocar unsigned
	li a1,148
	li a2,56
	li a3,0x0038
	li a4,0
	ecall
	#print int
	mv a0,t0
	li a7,136	# colocar unsigned
	li a1,236
	li a2,56
	li a3,0x0038
	li a4,0
	ecall
	ret
	
# syscall sleep
SLEEP:	li t0,5
LOOPHMS:li a0,1000   # 1 segundo
	li a7,132
	ecall
	addi t0,t0,-1
	#print seg
	mv a0,t0
	li a7,101
	li a1,120
	li a2,120
	li a3,0x0038
	li a4,0
	ecall
	bne t0,zero,LOOPHMS	
	ret
	
# CLS Clear Screen Randomico
CLSV:	li a7,141
	ecall
	li a7,148
	li a1,0
	ecall
	ret

# DrawLines Bresenham
DRAW:	li t2,0	
	li t0,1
	li s4,320
	li s5,240
LOOPDRAW: li t1,0
	  li s0,0
	  li s1,0
	  li s2,319
	  li s3,239
	li t1,0	  
FOR1:	bge t1,s4, SAI1
	mv a0,s0
	mv a1,s1
	mv a2,s2
	mv a3,s3
	mv a4,t2
	li a5,0
	li a7,47
	ecall
	addi s0,s0,1
	addi s2,s2,-1
	add t2,t2,t0
	addi t1,t1,1
	j FOR1

SAI1:	li s2,0
	li s1,0
	li s0,319
	li s3,239
	li t1,0
FOR2:	bge t1,s5, SAI2
	mv a0,s0
	mv a1,s1
	mv a2,s2
	mv a3,s3
	mv a4,t2
	li a5,0
	li a7,47
	ecall
	addi s1,s1,1
	addi s3,s3,-1
	add t2,t2,t0
	addi t1,t1,1
	j FOR2
SAI2:	addi t0,t0,1
	j LOOPDRAW


.include "../SYSTEMv17b.s"






