#Jorge Elías García
#Fecha: 
#Ejercicio Random para repasar. 

        .data
msginicial:     .asciiz "\nIntroduce dos flotantes y devolveremos el más pequeño. 0 = FIn. \n "
primerfloat:    .asciiz "\nEl primer float: \n "
segundoflat:    .asciiz "\n Segundo flat: \n "
mostramosfloat:     .asciiz "\n Número: \n "
salir:      .asciiz "\n 3.2 para salir: \n"
firstresult:    .asciiz "\n El número más pequeño es: "

        .text
main: 
  #Mostramos mensaje inicial por pantalla
  la $a0, msginicial
  li $v0, 4
  syscall

  #Recibimos un flotante
  la $a0, primerfloat
  li $v0, 4
  syscall

  li $v0, 6
  syscall
  mov.s $f2, $f0 #$f2 --> Primer float

  #Recibimos segundo float

  la $a0, segundoflat
  li $v0, 4
  syscall

  li $v0, 6
  syscall
  mov.s $f4, $f0 #$f4 --> Segundo float

  #Mostramos ambos números, si quiere salir que introduzca un cero
  la $a0, mostramosfloat
  li $v0, 4
  syscall

  li $v0, 2
  mov.s $f12, $f2
  syscall

  la $a0, mostramosfloat
  li $v0, 4
  syscall

  li $v0, 2
  mov.s $f12, $f4
  syscall
  
  #Si introduce un cero salimos
  la $a0, salir
  li $v0, 4
  syscall

  #Recibimos entero
  li $v0, 6
  syscall
  move $f6, $f0 #$f6 número para continuar

  li.s $f20, 3.2

  if: 
    c.eq.s $f20, $f6
          bc1t fin
  
  if1: 
     c.lt.s $f2, $f4
           bc1t else
           la $a0, firstresult
           li $v0, 4
           syscall
           li $v0, 2
           mov.s $f12, $f4
           syscall
           b iffin

  else: 
           la $a0, firstresult
           li $v0, 4
           syscall
           li $v0, 2
           mov.s $f12, $f2
           syscall
           b iffin

  iffin1: 

  fin: 
    
    li $t5, 7
    li $v0, 5
    move $v0, $t5
    syscall

    la $a0, final
    li $v0, 4
    syscall
    li $v0, 10
    syscall


  