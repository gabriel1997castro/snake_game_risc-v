# testa a exce��o de instru��o inv�lida
# s� funciona em m�quina Von Neummann - Rars -> self-modifying code

.text
MAIN:	la t0,MAIN
	li t1,0xFFFFFFFF  # instru��o inv�lida
	sw t1,24(t0)
	nop
	nop
	nop		  #local da instru��o inv�lida
	nop

FIM:  	j FIM
