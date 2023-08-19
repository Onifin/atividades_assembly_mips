#IAN ANTONIO FONSECA ARAÚJO
#MATRÍCULA: 20200076900

.data
	a: .asciiz "Digite o início do intervalo (a): "
	b: .asciiz "Digite o final do intervalo (b): "
	TOL: .asciiz "Digite a tolerância do erro relativo: "
	raiz: .asciiz "A raiz da função é aproximadamente: "
	itMax: .word 10
	numfloat: .float 10.0
	zero: .float 0.0
	dois: .float 2.0
.text
	.main:
		lwc1 $f1, zero #cria um float que vale 0
		lwc1 $f27, dois #cria um float que vale 2
		
		#--------------------------ENTRADA--------------------------#
		
		la $a0, a
		jal imprimeString
		jal leFloat
		
		add.s $f2, $f1, $f0 #armazena o valor que está em f0 em f2 (f2 = a)
		
		la $a0, b
		jal imprimeString
		jal leFloat
		
		add.s $f3, $f1, $f0 #armazena o valor que está em f0 em f3 (f3 = b)
		
		la $a0, TOL
		jal imprimeString
		jal leFloat
		
		add.s $f4, $f1, $f0 #armazena o valor que está em f0 em f3 (f4 = TOL)
		
		lw $t1, itMax #itMax = 10
		
		#-----------------------------------------------------------#
		
		jal bisseccao
	
	#retorna x^3 -10 (x de entrada é f0 / O retorno da função é por f0)
	f:
		mul.s $f30, $f0, $f0 #f30 = x^2
		mul.s $f30, $f30, $f0#f30 = x^2 * x = x^3
		
		
		lwc1 $f31, numfloat #cria um float que vale 10
		sub.s $f0, $f30, $f31 #x^3 - 10
		
		jr $ra
	
	#executa o método da bissecção
	bisseccao:
		#a = f2
		#b = f3
		#TOU = f4
		#t1 = itMax
		#f27 = 2
		#f1 = 0
		
		addi $t4, $zero, 0 #contador
		
		while:
			beq $t4, $t1, end #se a iteração for máxima pare
			addi $t4, $t4, 1 #incrementa o contador
			
			sub.s $f26, $f3, $f2 #(b-a)
			div.s $f26, $f26, $f27 #x = (b-a)/2
			add.s $f0, $f2, $f26 #x = a + (b-a)/2
			
			add.s $f25, $f0, $f1 #salva x em uma variável auxiliar
			
			jal f #f(x)
			
			add.s $f24, $f0, $f1 #salva f(x) em uma variável auxiliar
			
			c.eq.s $f0, $f1 #se f(x) = 0, pare
                        bc1t end #pule para end
			
			c.lt.s $f26, $f4 #se o erro atual for menor que o tolerado pare
			bc1t end #pule para end
			
			add.s $f0, $f2, $f1 #armazena "a" em f0
			jal f #f(a)
			
			mul.s $f24, $f24, $f0 #f24 = f(x) * f(a)
			
			c.lt.s $f24, $f1  #se f(x)*f(a) for menor que 0 a raiz está entre a e x
			bc1t entreAeX #pule para entreAeX
			
			entreBeX:
				add.s $f2, $f1, $f25 #a = x
				j while #volta para o loop
			
			entreAeX:
				add.s $f3, $f1, $f25 #b = x
				j while #volta para o loop
		end:	
			la $a0, raiz
		        jal imprimeString
		        
		        add.s $f12, $f1, $f25 #prepara x par imprimir
		
			li $v0, 2 #imprime o que está em f12
        		syscall
        		
        		li $v0, 10 #encerra o programa
        		syscall
        		
			jr $ra
	#ler float e armazenar em f0
	leFloat:
		li $v0, 6
		syscall
		
		jr $ra
		
	#imprime no console a string que está em a0
	imprimeString:
		li $v0, 4
		syscall
		
		jr $ra