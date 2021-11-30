.data 		
	elementos: .asciiz 			"VALOR A SER ARMAZENADO:"	# LABEL 1 	
	numero: .asciiz 			"VALOR A SER PESQUISADO:"	# LABEL 2
	verdadeiro: .asciiz 			"O valor est� no vetor"     	# LABEL 3
	falso: .asciiz 				"N�o est� no vetor"		# LABEL 4
	array: .space 40 			# 40 bytes= 10 inteiros

.text 
	
	# INSERINDO VALORES NO VETOR
	la $t0, array	# endere�o do array
	li $t1, 10	# limite do 'for' decrescente
	li $t2, 0	# primeiro valor do array

	Loop:			
	subi $t1, $t1, 1	# subtra��o de -1 do valor t1
	bltz $t1, Exit		# caso t1 for maior que 0, vai sair do la�o
	li $v0, 4		# imprimir a mensagem
	la $a0, elementos    	# endere�o label e mensagem ao usu�rio
	syscall				
	li $v0, 5		# ler o n�mero
	syscall			
	sw $v0, array($t2)	# valor digitado
	addi $t2, $t2, 4	# Aumenta o valor  // adiciona o valor a array
	j Loop
	Exit:
	
	# LOOP PARA SOLICITAR AO USU�RIO O N�MERO A SER PESQUISADO						
	li $v0, 4		# imprimindo a mensagem
	la $a0, numero    			
	syscall					
	li $v0, 5		# valor digitado
	syscall					
	move $t4, $v0		# mover o valor de v0 para t4
	
	# PESQUISANDO NO VETOR
	li $t1, 10 		# limite  do 'for'
	li $t2, 0		# primeiro valor do array
	
	Loop2: 
	subi $t1, $t1, 1		# subtrai 1 de t1
	bltz $t1, naoEncontrado		# caso t1 maior 0
	lw $t3, array($t2)		# carrega o valor na posi��o t2 para t3
	beq $t3, $t4, encontrado	# foi encontrado
	addi $t2, $t2, 4			
	j Loop2
	
	encontrado:
	li $v0, 4		# imprimindo mensagem:
	la $a0, verdadeiro    	# "O valor est� no vetor"
	syscall					
	j Exit2			# encerrando a busca
	
	naoEncontrado:
	li $v0, 4		# imprimiindo mensagem:
	la $a0, falso    	# "N�o est� no vetor"
	syscall			# chamada do sistema
	Exit2:
