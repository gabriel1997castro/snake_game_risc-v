 .text

TelaFundo:

#la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
#csrw tp,utvec 		# seta utvec para o endereço tp
#csrsi ustatus,1 	# seta o bit de habilitação de interrupção em ustatus (reg 0)

# Pinta a tela de verde

li a0, 0x00228B22
li a1, 0
li a7, 148
ecall

# Foram feitos duas linhas para cada lado da borda, apenas para aumentar a espessura da borda

#linha superior fora do retangulo
li a0, 15
li a1, 40
li a2, 305
li a3, 40
li a4, 0x0000
li a5, 0
li a7, 147
ecall 

li a0, 15
li a1, 39
li a2, 305
li a3, 39
li a4, 0x0000
li a5, 0
li a7, 147
ecall 

####################### Linha superior pertencente ao retangulo

#----linha mais interna do retangulo
li a0, 15		# x0=15
li a1, 45		# y0=45
li a2, 305		# x1=305
li a3, 45		# y1=45
li a4, 0x0000		# cor preta
li a5, 0			# frame = 0
li a7, 147
ecall 
#----
li a0, 15
li a1, 44
li a2, 305
li a3, 44
li a4, 0x0000
li a5, 0
li a7, 147
ecall 
##################### Linha lateral direita

#----linha mais interna do retangulo
li a0, 305
li a1, 45
li a2, 305
li a3, 220
li a4, 0x0000
li a5, 0
li a7, 147
ecall 
#----
li a0, 306
li a1, 45
li a2, 306
li a3, 220
li a4, 0x0000
li a5, 0
li a7, 147
ecall 
###################### Linha inferior do retangulo 

#----linha mais interna do retangulo
li a0, 306
li a1, 220
li a2, 15
li a3, 220
li a4, 0x0000
li a5, 0
li a7, 147
ecall 
#----
li a0, 306
li a1, 221
li a2, 15
li a3, 221
li a4, 0x0000
li a5, 0
li a7, 147
ecall 
###################### Linha esquerda

#----linha mais interna do retangulo
li a0, 15
li a1, 220
li a2, 15
li a3, 45
li a4, 0x0000
li a5, 0
li a7, 147
ecall
#----
li a0, 14
li a1, 220
li a2, 14
li a3, 45
li a4, 0x0000
li a5, 0
li a7, 147
ecall
 
ret


#li a7, 10
#ecall
#.include "SYSTEMv17b.s"
