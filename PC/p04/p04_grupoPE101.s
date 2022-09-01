#Jorge Elías García 


# practica 4. Principio de computadoras
# OBJETIVO: introduce el codigo necesario para reproducir el comportamiento del programa
# C++ que se adjunta como comentarios
# Debes documentar debidamente el uso de los registros que has elegido y la correspondencia
# con las variables que has utilizado.

#include <iostream>
#include <iomanip> // para set precision
#int main() {
#    std::cout << "P4 Principios de computadores\n";
#    float numero,sumap,suman;
#	int positivos,negativos;
#   positivos=0;
#   negativos=0;
#	suman=0;
#	sumap=0;
#	do {
#       // Introducir el numero
#       std::cout << "Introduzca el valor del numero (0 para salir): ";
#       std::cin >> numero;
#       if ( numero== 0 ) brea
#       // verificar el signo
#       if (numero >0){
#	      positivos++;
#	   	  sumap+=numero;
#		} 
#       else{
#		 negativos++;
#	     suman+=numero;
#		}
#       } while (true);
#		// visuliza el numero de positivo y negativos con sus sumas
#		
#      std::cout << "El numero de valores positivos es: " << positivos << " y su suma es= " << std::setprecision(15) << sumap << std::endl;;
#	   std::cout << "\nEl numero de valores negativos es: " << negativos << " y su suma es= " << std::setprecision(15) << suman << std::endl;;
#	   std::cout<<"\n Fin del programa\n";
#      return 0;
#  }




#$f2 = numero
#$f20 = 0
#$f22 = sumap 
#$f24 = suman


#$t1 = Positivos
#$t2 = Negativos

	.data		# directiva que indica la zona de datos
titulo: 	.asciiz	"P4 Principios de computadores.\n" 
msgpregunta:    .asciiz "Introduzca el valor del numero (0 para salir):\n"
msg1:           .asciiz "El numero de valores positivos es:  "
msg2:           .asciiz "\nEl numero de valores negativos es:  "
msg3:           .asciiz " y su suma es= "
msgfin:			.asciiz "\nFIN DEL PROGRAMA."


	.text		# directiva que indica la zona de código
main:

	#Mostramos por pantalla el mensaje inicial
	la $a0, titulo
	li $v0, 4
	syscall

     #Inicializamos ambos contadores a cero 
	li $t1, 0  #Contador de números positivos
	li $t2, 0  #Contador de números negativos

	   
      #Inicializamos los sumatorios
	li.s $f22, 0.0  #$f22 = sumap
	li.s $f24, 0.0  #$f24 = suman


     #Cargamos en el registro $f20 un cero, para la comparación
	li.s $f20, 0.0

	etiqueta_do: 
	  
	  #Mostramos por pantalla el mensaje para que introduzca el flotante
	  la $a0, msgpregunta
	  li $v0, 4
	  syscall

	  #Recibimos el numero flotante
	  li $v0, 6
	  syscall
	  mov.s $f2, $f0 #$f2 = Numero
      

      #Si el número introducido es igual a cero, terminamos el programa
	  if: 
	    c.eq.s $f2, $f20
		       bc1t fin 

	  iffin: 
      

	  #Determinamos si el númeo es positivo o negativo
	  if2: 
	      c.lt.s $f20, $f2 
		         bc1t else
				 #Operaciones si es negativo
				 add.s $f24, $f24, $f2
				 addi $t2, $t2, 1

				 b etiqueta_do

     #Operaciones si es postivo
	  else:  
	      add.s $f22, $f22, $f2
		  addi $t1, $t1, 1

		  b etiqueta_do

  fin: 
    
	#Mostramos el mensaje 
    la $a0, msg1
    li $v0, 4
    syscall
	#Mostramos el número de positivos
	li $v0, 1
	move $a0, $t1
	syscall
	#Mostramos el mensaje
	la $a0, msg3
	li $v0, 4
	syscall
	#Mostramos la suma de positivos
	li $v0, 2
	mov.s $f12, $f22
	syscall
	
	#Mostramos el mensaje 
    la $a0, msg2
	li $v0, 4
	syscall
	#Mostramos el número de negativos
	li $v0, 1
	move $a0, $t2
	syscall
    #Mostramos el mensaje
	la $a0, msg3
	li $v0, 4
	syscall
	#Mostramos la suma de negativos
	li $v0, 2
	mov.s $f12, $f24
	syscall

	#Mostramos el mensaje final y salimos
	la $a0, msgfin
	li $v0, 4
	syscall	
	li $v0,10
	syscall