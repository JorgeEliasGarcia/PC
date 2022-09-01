.data 

.text 
main: 
  
  li $v0, 5
  syscall
  move $a0, $v0 #Almcanemaos en $a0 la base
  
  jal factorial
  move $t0, $v0
  li $v0, 1
  move $a0, $t0
  syscall

  li $v0, 10
  syscall

  factorial: 
    #Caso base es el factorial de 1. 
    bgt $a0, 1, caso_general
    li $v0, 1 #Retornamos 1, ya que 1! = 1
    jr $ra 

  caso_general: 
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp) 

    addi $a0, -1
    jal factorial

    lw $ra, 0($sp)
    lw $a0, 4($sp)
    
    mul $v0, $v0, $a0
    jr $ra