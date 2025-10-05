.data

	valorA: 	.asciiz	"Digite o valor A (0/1): "
	valorB: 	.asciiz "Digite o valor B (0/1): "
	valorC: 	.asciiz "Digite o valor C (0/1): "
	
	resultado:	.asciiz "Resultado: "

.text
.globl main

main:

	#------ LEITURA DE VALORES ------ #
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
