
.data


.text
	nop
	nop
	nop
	csrr t0, 3072 
	csrr t1, 3073
	csrr t2, 3074
	csrr t3, 3200
	csrr t4, 3201	
	csrr t5, 3202

END: 	addi a7, zero, 10
	ecall
	
