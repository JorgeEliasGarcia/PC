# practica 7. Principio de computadoras
# OBJETIVO: introduce el codigo necesario para reproducir el comportamiento del programa
# C++ que se adjunta como comentarios
# Debes documentar debidamente el uso de los registros que has elegido y la correspondencia
# con las variables que has utilizado.

#include <iostream>
#include <stdio.h>
#define nrows 3
#define ncols 4
#/* EN MIPS es multiplicar_columna(direccion base de m1,indice de columna a multiplicar, indice de columna seleccionada)
#void multiplicar_columna(int m1[nrows][ncols],int c,int cs){
#    int i;
#	for (i = 0; i< nrows; i++)
#		m1[i][c]*=m1[i][cs];
#	
#}
#
#/* EN MIPS es multiplicar_matrix( dirección base m1, índice de columna seleccionada)*/
#
#void multiplicar_matrix(int m1[nrows][ncols],int cs){
#	int j;
#	for (j= 0; j < ncols ; j++){
#   if (j!=cs)
#		multiplicar_columna(m1,j,cs);
#	}
#   multiplicar_columna(m1,cs,cs);		
#}
#
# /* EN MIPS quiero que el cálculo de los desplazamientos estén optimizados.*/
# 
#void print_matrix(int ma[nrows][ncols],int f, int c){
#	int i,j;
#		for (i = 0; i< f ; i++) {
#			for (j = 0; j < c ; j++)
#				std::cout << ma[i][j] << " ";
#			std::cout << std::endl;
#		}
#}
#int main(void) {
#	
#	int matrix1[nrows][ncols] = {{1,0,1,0},{2,0,1,0},{2,3,3,1}};
#	int selection;
#	int indice;
#	
#	do {
#		
#		do {
#			std::cout << "Elija la columna a multiplicar (1-4) (0 para salir):";
#			std::cin >> selection;
#		} while (selection < 0 || selection > ncols);
#		std::cout << "Matriz\n";
#		print_matrix(matrix1,nrows,ncols);
#		indice=selection-1;
#		multiplicar_matrix(matrix1,indice);
#		std::cout << "El resultado de la multiplicacion es:\n";	
#		print_matrix(matrix1,nrows,ncols);
#		
#   } while (selection != 0);
#   std::cout << "\nFIN DEL PROGRAMA.";	
#	return(0);
#}

nrows=3
ncols=4
size=4

	.data		# directiva que indica la zona de datos
titulo: 		.asciiz	"P7 Principios de computadores.\n" 
msgpregunta:    .asciiz "Elija la columna a multiplicar (1-4) (0 para salir):"
msg1:           .asciiz "Matriz\n"
msg2:			.asciiz "El resultado de la multiplicacion es:\n"
msgfin:			.asciiz "\nFIN DEL PROGRAMA."
separador:      .asciiz " "
newline:        .asciiz "\n"
matrix1:	.word	1, 0, 1, 0
			.word	2, 0, 1, 0
			.word	2, 3, 3, 1
			

	.text		# directiva que indica la zona de código
main:

    li $v0, 4
	la $a0, titulo
	syscall
    
  etiqueta_do: 

	li $v0, 4
	la $a0, msgpregunta
	syscall

	li $v0, 5
	syscall
	move $a0, $v0  #Guardamos en $a0 el índice de la columna introducida
	

	beqz $a0, fin  #En caso de introducir un cero, terminamos ejecución


    lw $t0, ncols #$t0 = ncols, para la comprobación

	#Comprobamos que la columna introducida por el usuario es correcta
	bgt $a0, $t0, etiqueta_do #En caso de que el número introducido sea mayor que el número de columna, preguntamos de nuevo 
	blez $a0, etiqueta_do     #En caso de que el indice sea igual o menor que cero, preguntamos de nuevo 

    li $v0, 4
	la $a0, msg1
	syscall
     
	#Guardamos los valroes de los argumentos de la función
	lw $a1, nfil  #$a1 = nrows
	lw $a2, ncol  #$a2 = ncols
	la $a3, mat   #$a3 = matrix
	
    
	#Guardamos los dato en pila antes de llamar a la función. 
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)


	jal print_matrix

	#Recuperamos los valores y restablecemos el puntero de pila
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 20

    b etiqueta_do

	print_matrix: 
	
	  #$a1 = nrows
	  #$a2 = ncols
	  #$a3 = dirección base de la matrix

      #Guardamos en pila los argmentos de la función. 
	  addi $sp, $sp, -16
      sw $ra, 0($sp)
	  sw $a1, 4($sp)
	  sw $a2, 8($sp)
	  sw $a3, 12($sp)

	 
      move $t0, $zero #Inicializamos $t0 a cero, para realizar la búsqueda
      move $t1, $zero #Inicializamos $t1 a cero, para realizar la búsqueda
    

      for: 
        
        bge $t0, $a1, fin_for

        for_fila: 

          bge $t1, $a2, fin_for_fila

          lw $t2, 0($a3) #Almaceno en $t2 el elemento a mostrar
          move $a0, $t2
          li $v0, 1
          syscall
          li $v0, 4
          la $a0, separador
          syscall

          addi $a3, 4 #Actualizo $a3, para apuntar al siguiente elemento
          addi $t1, 1
          b for_fila

        fin_for_fila: 

          la $a0, newline
          li $v0, 4
          syscall
          addi $t0, 1 #Actualizo el contador de filas
          move $t1, $zero #Reinicio el contador de columna a 0
          b for 

      fin_for: 

	  #Restablecemos los valores de los argumentos de la función y el puntero de pila 
	 
      lw $ra, 0($sp)
	  lw $a1, 4($sp)
	  lw $a2, 8($sp)
	  lw $a3, 12($sp)
      addi $sp, $sp, 16
      jr $ra 
	

  fin: 

    li $v0, 4
	la $a0, msgfin
	syscall

	li $v0,10
	syscall
 


 
