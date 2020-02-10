.text 
LOSE: 	#li s11, 0x00000000
	addi sp, sp, -8
	sw ra, (sp)
	sw s6, (sp)
	jal MusicaPerdeu
	jal PrintLose
	li s6, 3000
	jal Sleep
	lw s6, (sp)
	lw ra, (sp)
	addi sp, sp, 8
	j IniciaJogo
