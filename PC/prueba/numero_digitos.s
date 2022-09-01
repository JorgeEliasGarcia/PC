.data
       

separador:  .asciiz " Introduzca el número " # separador entre numeros
newline:    .asciiz "\n"
titulo:     .asciiz "\nSuma de los dígitos de un número entero\n"

    
    .text
main:

  li        $v0, 4
  la        $a0, titulo
  syscall 

  li $v0, 4
  la $a0, separador
  syscall

  li $v0, 5
  syscall
  move $a1, $v0    #Almacenamos en $a1 el número introducido para pasarlo como parámetro. 

  li $a2, 10        #Cargamos un 10 como segundo parámetro

  jal suma_digitos 



  suma_digitos: 
    #Caso base es que el número sea menor que 10
    bge $a0, 10, casogeneral 
    move $v0, $a0
    jr $ra

  casogeneral: 
    addi $sp, $sp, -8
    sw   $ra, 0($sp)

    div $a0, $a2  
    mflo $a0    #Almacenamos el resto de la división y lo guardamos en pila 
    sw $a0, 4($sp) 

    mfhi $a0
    jal suma_digitos

    lw $ra, 0($sp) 
    lw $a0, 4($sp) 
    add $v0, $v0, $a0
    jr $ra



    
