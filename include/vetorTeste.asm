.data

vetor: 	.align 2 #Align in words
	.space 1024
	
.text

la t0, vetor
li t1, 3
sw t1, 0(t0)

li t1, 4
sw t1 4(t0)
sw t1, 8(t0)
li t1, 7
sw t1, 12(t0)

lw a0, 0(t0)
lw a1, 12(t0)
