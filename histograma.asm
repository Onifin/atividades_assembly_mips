#IAN ANTONIO FONSECA ARAÚJO
#MATRÍCULA: 20200076900

.data
	V: .word 9, 5, 7, 5, 3, 4, 0, 2, 6, 4, 2, 5, 4, 1, 2, 1, 6, 2, 2, 3, 6, 3, 0, 0, 7, 8, 3, 4, 5, 4, 0, 5, 2, 9, 8, 7
	H: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	tamanho: .word 36
	espaco: .byte ' '
	
.text
	addi $t0, $zero, 0 #index
	addi $s0, $zero, 4 
	lw $t2, tamanho #tamanho
	mul $t2, $t2, $s0 #tamanho em bytes
	
	while:
   		beq $t0, $t2, end  #se t0 = tamanho acaba o while
   		
   		lw $t3, V($t0) #pega o valor do vetor
   		
   		mul $t3, $t3, $s0 #acha a posiçao no histograma
   		
   		lw $t4, H($t3) #busca quantos já foram contados
   		
   		addi $t4, $t4, 1 #adiciona 1 ao contador
   		
   		sw $t4, H($t3) #adiciona o novo valor ao histograma
   	
   		addi $t0, $t0, 4 #incrementa o contador
   		
    		j while   # Volta para o início do loop

	end:
		addi $t2, $zero, 40 
		addi $t5, $zero, 0 #index para imprimir
		while2:
			beq $t5, $t2, end2  #se t0 = tamanho acaba o while
			
			lw $t6, H($t5)
			
			li $v0, 1
			move $a0, $t6
			syscall
			
			li $v0, 4
			la $a0, espaco
			syscall 
			
			addi $t5, $t5, 4
			
			j while2   # Volta para o início do loop
		end2:
		
			
