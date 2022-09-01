.data 

.text 
main: 
  
  li $v0, 5
  syscall
  move $a0, $v0 #Almcanemaos en $a0 la base

  li $v0, 5
  syscall
  move $a1, $v0 #Almacenamos en $a1 la potencia. 
  
  jal potencia 
  move $t0, $v0
  li $v0, 1
  move $a0, $t0
  syscall

  li $v0, 10
  syscall


  potencia: 
  
    #Caso base es que la potencia sea <= 1
    bne $a1, 1, caso_general
    move $v0, $a2 #Retornanermos el valor de la base. 
    jr $ra

    caso_general: 

      addi $sp, $sp, -12 
      sw $ra, 0($sp)
      sw $a1, 4($sp)
      sw $a2, 8($sp) 

      addi $a1, -1 #Disminuimos en 1 la potencia. 
      jal potencia
      
      lw $ra, 0($sp)
      lw $a1, 4($sp)
      lw $a2, 8($sp) 
      addi $sp, $sp, 12

      mul $v0, $v0, $a2
      jr $ra
      
