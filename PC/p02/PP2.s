.data		# directiva que indica la zona de datos
titulo: 	.asciiz	"\nSuma las cifras de un número entero. Introduzca un 0 para salir del programa.\n "
msgnumero:	.asciiz	"\n\nIntroduzca un entero para calcular la suma de sus cifras (0 para salir): "

msgresultado1:	.asciiz	"\nLa suma de las cifras es  "
msgfin:			.asciiz "\nFIN DEL PROGRAMA."


.text		# directiva que indica la zona de código
main:
	# IMPRIME EL TITULO POR CONSOLA
	# std::cout << "Suma las cifras de un número entero." << std::endl;
	# std::cout << "Introduzca un 0 para salir del programa." << std::endl;
 
	la	$a0,titulo
	li	$v0,4
	syscall

   
	# EL MAYOR PORCENTAJE DEL CÓDIGO C++ SE ENCUENTRA DENTRO DE UNA ESTRUCTURA do { ...  } while (true).
	# IMPLEMENTA EN MIPS ESE BUCLE INFINITO, Y A CONTINUACIÓN DESARROLLA CADA UNA DE LAS SECCIONES QUE 
	# SE ENCUENTRAN EN SU INTERIOR.

	etiqueta_do:

	# INTRODUCE EN ESTA SECCION EL CÓDIGO MIPS EQUIVALENTE AL SIGUIENTE FRAGMENTO C++
	# TEN EN CUENTA QUE break NO ES SINO UN SALTO A LA SIGUIENTE INSTRUCCION QUE ESTE FUERA DEL BUCLE
	# do { ...  } while (true).
	#         std::cout << "Introduzca un entero para calcular la suma de sus cifras (0 para salir): ";
	#         std::cin >> numero;
	#		  if (numero == 0) break;

      la $a0, msgnumero
      li $v0, 4
      syscall

	  li $v0, 5
	  syscall
	  move $t0, $v0  #t0 = numero

	  if: 
	      bnez $t0,iffin
          b fin
	  iffin: 
	 
     # INTRODUCE EN ESTA SECCION EL CODIGO MIPS EQUIVALENTE AL SIGUIENTE FRAGMENTO C++
	 #         if (numero < 0 ) numero = 0 - numero;

	  if1: 
	      bgez $t0, iffin1
	      sub $t0, $zero, $t0

	  iffin1: 
 
	# INTRODUCE EN ESTA SECCION EL CODIGO MIPS EQUIVALENTE AL SIGUIENTE FRAGMENTO C++
	#         suma = 0;
	#         while ( numero != 0 ){
	#             cifra = numero % 10;
	#             suma += cifra;
	#             numero /= 10;
	#         }

      move $t1, $zero    #t1 = suma = 0
      li $t2, 10         #t2 = 10

      while:  
          beqz $t0, whilefin   
          div $t0, $t2
          mfhi $t3   # t3 = resto de la división numero / 10 (numero % 10)
          mflo $t0   # numero (t0) toma el valor del cociente: numero / 10
          add $t1, $t1, $t3
	
	      b while

  	  whilefin: 
		
	# INTRODUCE EN ESTA SECCION EL CODIGO MIPS EQUIVALENTE AL SIGUIENTE FRAGMENTO C++
	#         std::cout << "La suma de las cifras es " << suma << std::endl;	
	  li $v0, 4
	  la $a0, msgresultado1
	  syscall
	  li $v0, 1
	  move $a0, $t1
	  syscall
	

	j etiqueta_do
 
	fin:
	# las siguientes instrucciones  imprimen la cadena de fin y finalizan el programa
	li $v0,4
	la $a0,msgfin
	syscall
	li $v0,10
	syscall

	#Fin del programa