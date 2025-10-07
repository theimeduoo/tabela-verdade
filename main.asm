.data

	valorA: 	.asciiz	"Digite o valor A: "
	valorB: 	.asciiz "Digite o valor B: "
	valorC: 	.asciiz "Digite o valor C: "
	
	resultado:	.asciiz "Resultado: "

.text
.globl main

var:
 li $t1, 0 #i = 0
 li $t2, 8 #Índice final do loop

main:
 #Ler o valor de A
	li $v0, 4
	la $a0, valorA
	syscall
	
	li $v0, 5
	syscall
	move $a1, $v0 #Guarda o valor de A em $a1
	
	#Ler o valor de B
	li $v0, 4
	la $a0, valorB
	syscall
	
	li $v0, 5
	syscall
	move $a2, $v0 #Guarda o valor de B em $a2	
	#Ler o valor de C
	li $v0, 4
	la $a0, valorC
	syscall
	
	li $v0, 5
	syscall
	move $a3, $v0 #Guarda o valor de C em $a3
	
	#Mostrar mensagem "Resultado: "
	li $v0, 4
	la $a0, resultado
	syscall
	
	#Fazer o processamento das entradas enviadas
	jal func

	#Após o processamento, mostrar na tela o resultado
	move $a0, $v0
	li $v0, 1
	syscall
	
 #Volta para main se i < 8
 addi $t1, $t1, 1
 ble $t1, $t2, main

	#Finaliza o programa
	li $v0, 10
	syscall

func:
	xori $t4, $a1, 1 # $t4 = !A
	xori $t5, $a2, 1 # $t5 = !B
	xori $t6, $a3, 1 # $t6 = !C

	or $t7, $a1, $a2 # (A + B)
	or $t7, $t7, $a3 # (A + B) + C
	
	or $t8, $a1, $t5 # (A + !B)
	or $t8, $t8, $t6 # (A + !B) + !C
	
	or $t9, $t4, $a2 # (!A + B)
	or $t9, $t9, $t6 # (!A + B) + !C
	
	or $t0, $t4, $t5 # (!A + !B)
	or $t0, $t0, $t6 # (!A + !B) + !C
	
	and $v0, $t7, $t8 # (A+B+C) * (A+!B+!C)
	and $v1, $t9, $t0 # (!A+B+!C) * (!A+!B+!C)
	and $v0, $v0, $v1 # ((A+B+C) * (A+!B+!C)) * ((!A+B+!C) * (!A+!B+!C))
	
	#Retornar aonde parou na label main
	jr $ra
