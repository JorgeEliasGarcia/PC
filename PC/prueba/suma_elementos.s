 
size = 4

 .data
vec:   .word   12, 1, 4, 0, 2, 3
nelem:   .word  6
   
error_op:   .asciiz "\nError: opcion incorrecta.\n"
titulo:     .asciiz "\nSuma elementos vector\n"

    
    .text
main:

  li $v0, 4
  la $a0, titulo
  syscall 

  etiqueta_do: 
  
   la $a0, vec        #Guardamos en $a0 la dirección base del vector

   la $a1, vec 
   add $a1, $a1, size

   lw $a2, nelem      #Guardamos en $a2 el número de elementos
    
   #Guardamos elemento en pila antes de llamar a la función
   addi $sp, $sp, -16
   sw $ra, 0($sp)
   sw $a0, 4($sp)
   sw $a1, 8($sp)
   sw $a2, 12($sp)

   jal sumar_elementos 

   #Restablecemos los valores. 
   lw $ra, 0($sp)
   lw $a0, 4($sp)
   lw $a1, 8($sp)
   lw $a2, 12($sp)
   addi $sp, $sp, 16

   move $t0, $v0
   li $v0, 1
   move $a0, $t0
   syscall

   li $v0, 10
   syscall


   sumar_elementos: 
   #Caso base es que el núemero de elemento restantes por sumar sea = 0. 
   bnez $a2, casogeneral
   li $v0, 0 #Guardamos en el registro $v0 que usaremos de sumatorio un cero, como valor por defecto
   jr $ra 

   casogeneral: 
     #Lo primero que haremos es guardar en pila los operandos
     addi $sp, $sp, -16
     sw $ra, 0($sp)
     sw $a0, 4($sp)
     sw $a1, 8($sp)
     sw $a2, 12($sp)

     add  $a0, $a0, size #Apuntamos al siguiente elemento
     add  $a0, $a0, size
     add  $a1, $a1, size #Aputanmos al elemento anterior. 
     add  $a1, $a1, size
     addi $a2, $a2, -2   #Disminuimos en dos el número de elementos restantes por sumar_elementos

     jal sumar_elementos

     lw $ra, 0($sp)
     lw $a0, 4($sp)
     lw $a1, 8($sp)
     lw $a2, 12($sp)    
     addi $sp, $sp, 16

     lw $t0, 0($a0)
     lw $t1, 0($a1)

     add $t2, $t0, $t1
     add $v0, $v0, $t2
     
     jr $ra
