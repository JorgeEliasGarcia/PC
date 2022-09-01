# Practica 3. Principio de computadores
# Alumno: Jorge Elías García
# Fecha: 25/03/2022 
 
 .data
titulo: .asciiz "PR3 aproximación por serie geométrica\n"
finmsg: .asciiz "\nFIN DEL PROGRAMA.\n"
calmsg: .asciiz "\nResultado real = "
pidex:  .asciiz "\nIntroduzca el valor de x (|x|<1): "
piderr: .asciiz "\nIntroduzca el error objetivo: "
resmsg: .asciiz "\nResultado calculado para " 
termsg: .asciiz " terminos = " 
errmsg: .asciiz "\nError cometido para " 

    .text
main:
  #Imprimimos por pantalla el título del programa
  la $a0, titulo
  li $v0, 4
  syscall

  li.s $f20, 0.0 #Cargamos en $f20 el 0.0, para trabajar en las comparaciones
  li.s $f22, 1.0 #Cargamos en $f22 el 1.0. para trabajar en las operaciones y comparaciones
  li.s $f26, -1.0 #Cargamos en el $f26 el -1.0, para trabajar en las operaciones (sumatorio)

  etiqueta_do: 
    #Preguntamos el número al usuario  
    la $a0, pidex
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f2, $f0 # $f2 = numero_introducido

    #Si el número introducido es igual a 0, termina el programa
    if: 
      c.eq.s $f2, $f20
             bc1t fin
    iffin: 
    
    #Guardamos en el registro $f8 el valor absoluto del número introducido
    abs.s $f8, $f2

    #Comprobamos si el valor absouto del número es menor que uno
    if1: 
        c.lt.s $f8, $f22
               bc1t iffin1
               b etiqueta_do  #Si el valor absoluto es mayor que uno, preguntamos el numero de nuevo
    iffin1:

    #Preguntamos al usuario el error máximo 
    la $a0, piderr
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f4, $f0 # $f4 = Erros máximo introducido

    #Comrpobamos que el error introducido es mayor que cero 
    if2: 
       c.lt.s $f20, $f4
              bc1t iffin2
              b iffin1 #Si el error introducido es menor que 0, preguntamos el error de nuevo.
    iffin2: 
    
    #Calculamos el valor real ( 1 / 1 + numero) 
    add.s $f6, $f2, $f22  #Guardamos el del denominador en registro $f6
    div.s $f24, $f22, $f6  #Guardamos en el $f24 el valor real (1 / 1 + numero)

    #Comprobamos que el error introducido sea menor que el valor real
    if3: 
      c.lt.s $f4, $f24
             bc1t iffin3
             b iffin1 # Si el error es mayor que el valor real, preguntamos el error de nuevo.
    iffin3: 
    
    #Reutilizamos el registro $f6 y guardamos el error cometido. 
    #Lo inicializamos a 1, para garantizar que se cumple la condición del while la primera vez.  
    mov.s $f6, $f22 
    
    move $t0, 0 #Inicializamos en $t0 un 0, para usarlo a modo de exponente y contador.

    li $f10, $f20 #Inicializamos $f10 con un 0.
    li $f14, $f20 #Inicializamos $f14 con un 0.


    while: 
      c.lt.s $f6, $f4
            bc1t whilefin  #Si el error cometido es menor que el error introducido, fin del while.
            
        #Reutilizamos el $f8, para almacenar el resultado del sumatorio
      if4: 
          bnez $t0, iffin4
              mult.s $f10, $f26, $f26 #f10 = -1 * -1
              mult.s $f14, $f2, $f2   #f14 = numero * numero
              add.s $f8, $f10, $f14 #Almacenamos el valor del sumatorio
              sub.s $f6, $24, $f8  #Almacenamos el error cometido (Valor real - Valor del sumatorio)
              addi $t0, 1 #Aumentamos en 1 el contador

              b while
      iffin4: 

      mult.s $f10, $f10, $f26 #Almacenamos en $f10 el valor que ya tenía $f10 por -1. 
      mult.s $f14, $f14, $f2  #Almacenamos en $f14 el valor que ya tenía $f14 por numero.
      add.s $f8, $f10, $f14   #Almacenamos el valor del sumatorio
      sub.s $f6, $f24, $f8
      addi $t0, 1
      b while
    
    whilefin: 
      
      #Mostramos por pantalla número de iteraciones y el valor obtenido 

      #Mostramos por pantalla el mensaje resmsg
      la $a0, resmsg
      li $v0, 4
      syscall
      #Mostramos por pantalla el número de iteraciones
      li $v0, 1
      move $a0, $t0
      syscall
      #Mostramos por pantalla el mensaje termsg
      la $a0, termsg
      lis $v0, 4
      syscall
      #Mostramos por pantalla el valor obtenido mediante n iteraciones (valor del sumatorio)
      li $v0, 2
      mov.s $f12, $f8
      syscall
      
      #Mostramos por pantalla el error obtenido
       
      #Mostramos por pantalle el mensaje errmsg
      la $a0, errmsg
      li $v0, 4
      syscall
      #Mostramos por pantalla el número de iteraciones
      li $v0, 1
      move $a0, $t0
      syscall
      #Mostramos por pantalla el mensaje termsg
      la $a0, termsg
      lis $v0, 4
      syscall
      #Mostramos por pantalla el error obtenido
      li $v0, 2
      mov.s $f12, $f6
      syscall


    b etiqueta_do,

  fin: 
    #Se imprime el mensaje final y se finaliza el programa
    la $a0, finmsg
    li $v0, 4
    syscall
    li $v0, 10
    syscall
