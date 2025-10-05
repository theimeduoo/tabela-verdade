.data

	valorA: 	.asciiz	"Digite o valor A (0/1): "
	valorB: 	.asciiz "Digite o valor B (0/1): "
	valorC: 	.asciiz "Digite o valor C (0/1): "
	
	resultado:	.asciiz "Resultado: "

.text
.globl main

main:
	#Ler o valor de A
	li $v0, 4
	la $a0, valorA
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0 #Guarda o valor de A em $t1
	
	#Ler o valor de B
	li $v0, 4
	la $a0, valorB
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0 #Guarda o valor de B em $t2
	
	#Ler o valor de C
	li $v0, 4
	la $a0, valorC
	syscall
	
	li $v0, 5
	syscall
	move $t3, $v0 #Guarda o valor de C em $t3

	#Fazer o processamento das entradas enviadas
	jal func
	
	#Após o processamento, mostrar na tela o resultado
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	
#(A+B+C) * (A+!B+!C) * (!A+B+!C) * (!A+!B+!C)

#A = $t1
#B = $t2
#C = $t3

func:
	xori $t4, $t1, 1 # $t4 = !A
	xori $t5, $t2, 1 # $t5 = !B
	xori $t6, $t3, 1 # $t6 = !C

	or $t7, $t1, $t2 # (A + B)
	or $t7, $t4, $t3 # (A + B) + C
	
	or $t8, $t1, $t5 # (A + !B)
	or $t8, $t8, $t3 # (A + !B) + !C
	
	or $t9, $t4, $t2 # (!A + B)
	or $t9, $t9, $t6 # (!A + B) + !C
	
	or $t0, $t4, $t5 # (!A + !B)
	or $t0, $t0, $t6 # (!A + !B) + !C
	
	and $v0, $t7, $t8 # (A+B+C) * (A+!B+!C)
	and $v0, $v0, $t9 # (A+B+C) * (A+!B+!C) * (!A+B+!C)
	and $v0, $v0, $t0 # (A+B+C) * (A+!B+!C) * (!A+B+!C) * (!A+!B+!C)
	
	and $v0, $v0, 1 #Retorna somente o último bit pois é o que precisamos como resultado
	
	#Retornar aonde parou na label main
	jr $ra
