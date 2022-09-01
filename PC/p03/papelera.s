# Practica 3. Principio de computadores
# Alumno: Jorge Elías García
# Fecha: 25/03/2022 
 
#CUESTIONES:

# 1) Mejoras para minimizar el número de operaciones. 

# Para optimizar el cógido, a la hora de calcular las potencias del sumatorio, en caso de que fuese 
# el exponente cero, cargo los registros empleados para almacenar las potencias a uno, puesto que 
# cualquier potencia de 0 es igual a uno. A continucación, en la siguiente iteración, multiplico el 
# valor que ya tenía el propio registro por el operando, ya que de esta manera se corresponde con la potencia.
# En este caso, sería 1 por el operando, correspondiente a la potencia uno. Sucesivamente se calculan
# las demás potencias. De este modo, evitamos emplear más bucles y optimizamos el código. 

# 2) Registros y criterio. 

# En el registro $f0 no he almacenado ningún valor, pues se suele emplear para el valor de retorno de
# punto flotante en subprogramas. 
#
# $f2 --> Numero_introducido
# $f4 --> Error_introducido
# $f6 lo he reutilizado: 
# $f6 --> ( 1 + numero_introducido)
# $f6 --> Valor absoluto del error cometido
# $f8 lo he reutilizado: 
# $f8 --> Valor absoluto del número introducido
# $f8 --> Valor del sumatorio
# $f10 --> Almacena las potencias de -1
#
# $f12 --> No he empleado este registro, pues se emplear para leer el número flotante a imprimir en pantalla.
#
# $f14 --> Almacena las potencias de Numero_introducido
# $f16 --> Almacena la multiplicación de los operandos. (una vez han sido elevados a la potencia correspondiente)
# $f18 --> Almacena el error cometido (No en valor absoluto, eso se guarda en $t6)
# 
# A continuación, he empleado los registros $f20 - $f30 para almacenar registros salvados: 
# $f20 --> Carga el 0.0
# $f22 --> Carga el 1.0
# $f24 --> Carga el valor de la función (1 / 1 + x)
# $f26 --> Carga el -1.0

#3) Como transformar el programa a doble precicisión y consecuencias en el programa. 

# En primer lugar, habría que modificar las extensiones .s por .d, para tener doble precisión. 
# Además de las instrucciones de syscall, puesto que para leer un número en doble precisión debemos 
# pasar al registro $v0 un 7. Para imprimir un flotante en doble precisión, debemos pasar al registro
# $v0 un 3. 
# Por otro lado,  cada uno de los valores ocuparía dos registros, por lo que solo emplearíamos
# o los registros pares o impares. 
# Finalmente, habría un cambio en el comportamiento del programa, puesto que al tener doble precisión
# y almacenar cada uno de los valores en dos registros, los calculos con decimales serían más exactos.



#CÓDIGO REALIZADO EN C++

##include <cmath>
#include <iostream>

#int main() {
#  std::cout << "PR3. Aproximación por serie geométrica." << std::endl;
#
#  // Preguntamos el número al usuario. En caso de que |x| >= 1, preguntamos de nuevo.
#  do {
#    double numero_introducido;
#    do {
#      std::cout << "Introduzca el valor de x (|x| < 1): " << std::endl;
#      std::cin >> numero_introducido;
#      if (numero_introducido == 0) {
#        std::cout << "FIN DEL PROGRAMA" << std::endl;
#        return 0;
#      }
#    } while (fabs(numero_introducido) >= 1);
#
#    // Calculamos y mostramos el Resultado real de la función (1 / 1 + x)
#
#    const double kValorReal = 1 / (1 + numero_introducido);
#    std::cout << "Resultado real: " << kValorReal << std::endl;
#
#    // Preguntamos el error máximo al usuario. En caso de ser menor que cero o mayor que el número
#    // introducido, preguntamos de nuevo.
#    double error_maximo;
#
#    do {
#      std::cout << "Introduzca el error objetivo: " << std::endl;
#      std::cin >> error_maximo;
#    } while (error_maximo < 0 || error_maximo > numero_introducido);
#
#    // Calculamos el valor del sumatorio mientras el error cometido sea mayor que el error máximo.
#    double error_cometido{1.0};
#    int contador{0};
#    double potencias_menos_uno{1.0};
#    double potencias_numero{1.0};
#    double sumatorio{0.0};

#    while (error_cometido > error_maximo) {
#      // En caso de ser 0 el exponente, las potencias valen uno, por lo que no hacemos ningún
#      // cálculo porque ya están inicializadas a 1.
#
#      if (contador != 0) {
#        potencias_menos_uno *= -1;  // Almacenamos las potencias.
#        potencias_numero *= numero_introducido;
#        sumatorio += potencias_menos_uno * potencias_numero;
#      } else {
#        sumatorio = 1.0;  // Si el exponente es cero, el sumatorio valdrá uno.
#      }
#      ++contador;
#      error_cometido = fabs(kValorReal - sumatorio);  // Calculamos el error cometido en valor abs.
#    }
#    std::cout << "Resultado para " << contador << " términos: = " << sumatorio << std::endl;
#    std::cout << "Error cometido para " << contador << " términos = " << error_cometido
#              << std::endl;
#
#  } while (true);
#  return 0;
#}


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

  # std::cout << "PR3. Aproximación por serie geométrica." << std::endl;

  #Imprimimos por pantalla el título del programa
  la $a0, titulo
  li $v0, 4
  syscall

  li.s $f20, 0.0 #Cargamos en $f20 el 0.0, para trabajar en las comparaciones
  li.s $f22, 1.0 #Cargamos en $f22 el 1.0. para trabajar en las operaciones y comparaciones
  li.s $f26, -1.0 #Cargamos en el $f26 el -1.0, para trabajar en las operaciones (sumatorio)

  etiqueta_do: 

  #  do {
  #    double numero_introducido;
  #    do { 
  #      std::cout << "Introduzca el valor de x (|x| < 1): " << std::endl;
  #      std::cin >> numero_introducido;
  #      if (numero_introducido == 0) {
  #        std::cout << "FIN DEL PROGRAMA" << std::endl;
  #         return 0;
  #      }
  #    } while (fabs(numero_introducido) >= 1);

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
    


  #    const double kValorReal = 1 / (1 + numero_introducido);
  #    std::cout << "Resultado real: " << kValorReal << std::endl;

    #Calculamos el valor real ( 1 / 1 + numero) 
    add.s $f6, $f2, $f22  #Guardamos el del denominador en registro $f6
    div.s $f24, $f22, $f6  #Guardamos en el $f24 el valor real (1 / 1 + numero)

    #Imprimimos en pantalla el valor real
    #Imprimimos el mensaje calmsg
    la $a0, calmsg
    li $v0, 4
    syscall
    #Imprimimos el valor numérico
    li $v0, 2
    mov.s $f12, $f24
    syscall


  #    do {
  #      std::cout << "Introduzca el error objetivo: " << std::endl;
  #      std::cin >> error_maximo;
  #    } while (error_maximo < 0 || error_maximo > numero_introducido);

    #Preguntamos al usuario el error máximo 
    la $a0, piderr
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f4, $f0 # $f4 = Error máximo introducido

    #Comrpobamos que el error introducido es mayor que cero 
    if2: 
       c.lt.s $f20, $f4
              bc1t iffin2
              b iffin1 #Si el error introducido es menor que 0, preguntamos el error de nuevo.
    iffin2: 
    
    

    #Comprobamos que el error introducido sea menor que el valor real
    if3: 
      c.lt.s $f4, $f24
             bc1t iffin3
             b iffin1 # Si el error es mayor que el valor real, preguntamos el error de nuevo.
    iffin3: 
    


  # double error_cometido{1.0};
  #    int contador{0};
  #    double potencias_menos_uno{1.0};
  #    double potencias_numero{1.0};
  #    double sumatorio{0.0};

  #    while (error_cometido > error_maximo) {  
  #      // En caso de ser 0 el exponente, las potencias valen uno, por lo que no hacemos ningún
  #      // cálculo porque ya están inicializadas a 1. 
  #
  #      if (contador != 0) {
  #        potencias_menos_uno *= -1;  // Almacenamos las potencias.
  #        potencias_numero *= numero_introducido;
  #        sumatorio += potencias_menos_uno * potencias_numero;
  #      } else {
  #        sumatorio = 1.0;  // Si el exponente es cero, el sumatorio valdrá uno.
  #      }
  #      ++contador;
  #      error_cometido = fabs(kValorReal - sumatorio);  // Calculamos el error cometido en valor abs.
  #    }
  # 


    #Reutilizamos el registro $f6 y guardamos el error cometido. 
    #Lo inicializamos a 1, para garantizar que se cumple la condición del while la primera vez.  
    mov.s $f6, $f22 
    
    li $t0, 0 #Inicializamos en $t0 un 0, para usarlo a modo de exponente y contador.

    li.s $f10, 0.0 #Inicializamos $f10 con un 0.
    li.s $f14, 0.0 #Inicializamos $f14 con un 0.

     #Reutilizamos el $f8, para almacenar el resultado del sumatorio. Lo inicializamos a cero.
    mov.s $f8, $f20

    while: 
      c.lt.s $f6, $f4
            bc1t whilefin  #Si el error cometido es menor que el error introducido, fin del while.

      if4: 
        bnez $t0, iffin4
          #Si el exponente es cero, siempre valdrá uno las potencias y la multiplicación
          li.s $f10, 1.0
          li.s $f14, 1.0
          li.s $f8, 1.0

          sub.s $f18, $f24, $f8  #Almacenamos en $f18 el error cometido 
          abs.s $f6, $f18        #Almacenamos en $f6 el valor absoluto del error cometido
          addi $t0, 1            #Aumentamos en uno el contador
          
          b while

      iffin4: 
      
      mul.s $f10, $f10, $f26   #Almacenamos en $f10 el valor que ya tenía $f10 por -1. (Potencias de -1)
      mul.s $f14, $f14, $f2    #Almacenamos en $f14 el valor que ya tenía $f14 por numero. (Potencia de x)
      mul.s $f16, $f10, $f14   #Almacenamos en $f16 el valor de la multiplicación
      add.s $f8, $f8, $f16     #Almacenamos el valor del sumatorio
      sub.s $f18, $f24, $f8    #Almacenamos en $f18 el error cometido
      abs.s $f6, $f18          #Almacenamos en $f6 el valor absoluto del error cometido
      addi $t0, 1              #Aumentamos en uno el contador
      b while
    
    whilefin: 
      

  #    std::cout << "Resultado para " << contador << " términos: = " << sumatorio << std::endl;
  #    std::cout << "Error cometido para " << contador << " términos = " << error_cometido
  #              << std::endl;
  #
  #  } while (true);


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
      li $v0, 4
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
      li $v0, 4
      syscall
      #Mostramos por pantalla el error obtenido
      li $v0, 2
      mov.s $f12, $f6
      syscall


    b etiqueta_do,
    

  #        std::cout << "FIN DEL PROGRAMA" << std::endl;
  #        return 0;

  fin: 
    #Se imprime el mensaje final y se finaliza el programa
    la $a0, finmsg
    li $v0, 4
    syscall
    li $v0, 10
    syscall
