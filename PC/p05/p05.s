# Nombre: Jorge Elías García
# Fecha: 13 abril 2021

#PSEUDOCÓDIGO 
#El preudocódigo se encuentra dividido en: main.cc(programa principal), matrix_t.h(declaración de la
#clase matrix_t) y matrix_t.cc(contiene las definiciones de la clase matrix_t)

# main.cpp: 

#include <iostream>

#include "p05.cc" 
#include "p05.h"

#int MostrarMenu() {
#  std::cout << "\n(1) Cambiar dimensiones\n(2) Obtener elemento [i,j]\n"
#               "(3) Invertir fila\n(4) Invertir columna\n(0) Salir\nElija opcion: ";
#  int opcion_elegida;
#  std::cin >> opcion_elegida;
#  return opcion_elegida;
#}

#int main() {
#  std::cout << "Práctica 5 de Principio de Computadores. Matrices" << std::endl;
#  matrix_t<int> matriz;
#  matriz.rellenar_matriz();
#  int opcion;
#  int elemento;

#  do {
#    matriz.Escribir();
#    opcion = MostrarMenu();
#    switch (opcion) {
#      case 1:
#        matriz.Redimensionar();
#        break;
#
#      case 2:
#        elemento = matriz.RetornarElemento();
#        if (elemento != -1) {
#         std::cout << elemento << std::endl;
#        }
#        break;

#      case 3:
#        matriz.InvertirFila();
#        break;

#      case 4:
#        matriz.InveretirColumna();
#        break;

#      default:
#        break;
#    }
#  } while (opcion != 0);

#  return 0;
#}

# matrix_t.h: 

#pragma once

#include <cassert> 
#include <iostream>
#include <vector>

#using namespace std;

#template <class T>
#class matrix_t {
# public:
#  matrix_t(const int = 0, const int = 0);
#  void rellenar_matriz();
#  void Redimensionar();
#  void InvertirFila();
#  void InveretirColumna();
#  int RetornarElemento() const;
#  
#  // getters
#  int get_m(void) const { return m_; };
#  int get_n(void) const { return n_; };

#  void Escribir(ostream& = cout) const;

# private:
#  int m_, n_;  // m_ filas y n_ columnas
#  vector<T> v_;
#  // Esta es una función fundamental del programa, pues recibiendo dos enteros, como si fuesen las
#  // posiciones de la matriz (SIN CONTAR INDICES CERO), accede a la posición indicada del vector
#  // aplicando la fórmula: (i - 1) * get_n() + (j - 1), siendo i la fila, j la columna y get_n()
#  // número de columnas.
#  int pos(const int, const int) const;
#};

# matrix_t.cc

#include "p05.h" 

#// Constructor de la clase matrix_t
#template <class T>
#matrix_t<T>::matrix_t(const int m, const int n) {
#  m_ = m;
#  n_ = n;
#  v_.resize(m_ * n_);
#}

#template <class T>
#void matrix_t<T>::Escribir(ostream& os) const {
#  os << "\nMatriz con dimensiones: ";
#  os << get_m() << "x" << get_n() << endl;
#  for (int i = 1; i <= get_m(); ++i) {
#    for (int j = 1; j <= get_n(); ++j) os << v_[pos(i, j)] << "\t";
#   os << endl;
#  }
#  os << endl;
#}

#// Esta es una función fundamental del programa, pues recibiendo dos enteros, como si fuesen las
#// posiciones de la matriz (EMPEZANDO A CONTAR DESDE EL 1,1), accede a la posición indicada del
#// vector aplicando la fórmula: (i - 1) * get_n() + (j - 1), siendo i la fila, j la columna y
#// get_n() número de columnas.
#template <class T>
#inline int matrix_t<T>::pos(const int i, const int j) const {
#  assert(i > 0 && i <= get_m());
#  assert(j > 0 && j <= get_n());
#  return (i - 1) * get_n() + (j - 1);
#}

#template <class T>
#void matrix_t<T>::rellenar_matriz() {
#  v_.resize(200);
#  m_ = 20;
#  n_ = 10;
#  for (int i{0}; i < 200; ++i) {
#    v_[i] = 100 + i;
#  }
#}

#template <class T>
#void matrix_t<T>::Redimensionar() {
#  std::cout << "\nIntroduzca numero de filas: ";
#  int m;
#  std::cin >> m;
#  if (m > 20 || m < 0) {
#    std::cerr << "\nError: dimension incorrecta. Numero de fila incorrecto.\n";
#    return;
#  }

# std::cout << "\nIntroduzca número de columnas: ";
#  int n;
#  std::cin >> n;
#  if (n > 10 || n < 0) {
#    std::cerr << "\nError: dimension incorrecta. Numero de columna incorrecto.\n";
#    return;
#  }
#  m_ = m, n_ = n;
#}

#template <class T>
#int matrix_t<T>::RetornarElemento() const {
#  std::cout << "\nObtener el elemento [i,j]. Introduzca indice i (primera fila indice 0): ";
#  int fila;
#  std::cin >> fila;
#  if (fila > get_m() - 1 || fila < 0) {
#    std::cerr << "\nError: dimension incorrecta. Numero de fila incorrecto.\n";
#    return -1;
#  }
#  std::cout << "\nObtener el elemento [i,j]. Introduzca indice j (primera columna indice 0): ";
#  int columna;
#  std::cin >> columna;
#  if (columna > get_n() - 1 || columna < 0) {
#    std::cerr << "\nError: dimension incorrecta. Numero de fila columna.\n";
#    return -1;
#  }

#  return v_[pos(fila + 1, columna + 1)];
#}

#template <class T>
#void matrix_t<T>::InvertirFila() {
#  std::cout << "\nInvertir la fila [i,*]. Introduzca indice i (primera fila indice 0): ";
#  int fila;
#  std::cin >> fila;
#  if (fila > get_m() - 1 || fila < 0) {
#    std::cerr << "\nError: dimension incorrecta. Numero de fila incorrecto.\n";
#    return;  // Salimos de la función sin modificar la fila, al no ser válida.
#  }
# // Como en cada iteración intercambiamos dos elementos únicamente necesitamos nºcol/2 iteraciones.
#  int numero_interaciones = get_n() / 2;
#  for (int i{1}, j{0}; j < numero_interaciones; ++i, ++j) {
#    // Tenemos que sumar 1 a la fila, ya que nuestro método pos recibe los índices comenzando desde
#    // el (1,1)
#    int primer_elemento = v_[pos(fila + 1, i)];
#    // Para obtener el elemento con el elemento a intercambiar el primer elemento empleamos la
#    // fórmula: (fila, nºcols - contador), para lo que usamos j inicializada en cero.
#    int segundo_elmento = v_[pos(fila + 1, get_n() - j)];
#    v_[pos(fila + 1, i)] = segundo_elmento;
#    v_[pos(fila + 1, get_n() - j)] = primer_elemento;
#  }
#}

#template <class T>
#void matrix_t<T>::InveretirColumna() {
#  std::cout << "\nInvertir la columna [*,j]. Introduzca indice j (primera fila indice 0): ";
#  int columna;
#  std::cin >> columna;
#  if (columna > get_n() - 1 || columna < 0) {
#    std::cerr << "\nError: dimension incorrecta. Numero de columna incorrecto.\n";
#    return;  // Salimos de la función sin modificar la columna, al no ser válida.
#  }
#  int numero_iteraciones = get_m() / 2;  // EL número de iteraciones será el número de filas entre
#                                         // 2, ya que en cada iteración alternamos 2 elementos.
#  for (int i{1}, j{0}; j < numero_iteraciones; ++i, ++j) {
#    int primer_elemento = v_[pos(i, columna + 1)];
#    // El elemento con el que intercambiar el elemento que estamos recorriendo se encuentra en la
#    // misma columna pero su fila es el número de filas - contador.
#    int segundo_elemento = v_[pos(get_m() - j, columna + 1)];
#    v_[pos(i, columna + 1)] = segundo_elemento;
#    v_[pos(get_m() - j, columna + 1)] = primer_elemento;
#  }
#}


maximoElementos=400 # numero de enteros maximo reservado para la matriz 1600 bytes
size=4 # bytes que ocupa un entero
    .data
mat:   .word   100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119
       .word   120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139
       .word   140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159
       .word   160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179
       .word   180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199
       .word   200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219
       .word   220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239
       .word   240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259
       .word   260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279
       .word   280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299
       .word   300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319
       .word   320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339
       .word   340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359
       .word   360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379
       .word   380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399
       .word   400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419
       .word   420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439
       .word   440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459
       .word   460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479
       .word   480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499
       

nfil:   .word   20 # nuemro de filas de la matriz
ncol:   .word   10 # numero de columnas de la matriz
separador:  .asciiz "  " # separador entre numeros
newline:    .asciiz "\n"
menu:       .ascii  "\n(1) Cambiar dimensiones\n(2) Obtener elemento [i,j]\n"
            .asciiz "(3) Invertir fila\n(4) Invertir columna\n(0) Salir\nElija opcion: "
error_op:   .asciiz "\nError: opcion incorrecta.\n"
msg_nfilas: .asciiz "\nIntroduzca numero de filas: "
msg_ncols:  .asciiz "\nIntroduzca numero de columnas: "
error_nfilas:   .asciiz "\nError: dimension incorrecta. Numero de fila incorrecto.\n"
error_ncols:    .asciiz "\nError: dimension incorrecta. Numero de columna incorrecto.\n"
error_dime:     .asciiz "\nError: dimension incorrecta. Excede el maximo numero de elementos (400).\n"
msg_i:      .asciiz "\nObtener el elemento [i,j]. Introduzca indice i (primera fila indice 0): "
msg_j:      .asciiz "\nObtener el elemento [i,j]. Introduzca indice j (primera columna indice 0): "
msg_f:      .asciiz "\nInvertir la fila [i,*]. Introduzca indice i (primera fila indice 0): "
msg_c:      .asciiz "\nInvertir la columna [*,j]. Introduzca indice j (primera columna indice 0): "
msg_elemento:   .asciiz "\nElemento obtenido en la posicion indicada: "
titulo:     .asciiz "\nPractica 5 de Principios de Computadores. Matrices.\n"
header:     .asciiz "Matriz con dimension "
x:          .asciiz " x "
msg_fin:    .asciiz "\nFin del programa.\n"

    
    .text
main:

  li $v0, 4
  la $a0, titulo
  syscall 
  li $v0, 4
  la $a0, newline
  syscall

  etiqueta_do: 
  
    jal mostrar_matriz   

    mostrar_menu: 

      #Mostramos el menu
      la $a0, menu
      li $v0, 4
      syscall
      #Recibimos el la opción elegida 
      li $v0, 5
      syscall
      move $t3, $v0 #Almacenamos en $t3 el número introducido en el menú
      beq $t3, 0, fin #Si número introducido es igual a 0, terminamos programa
      beq $t3, 1, obtener_dimensiones #Si el número es igual a 1, redimensionamos la matriz
      beq $t3, 2, obtener_elemento
      beq $t3, 3, invertir_fila
      beq $t3, 4, invertir_columna
      #En caso de escribir una opcion incorrecta, mostramos el mensaje de error y de nuevo el menu
      la $a0, error_op
      li $v0, 4
      syscall
      b mostrar_menu 

  obtener_dimensiones: 

    li $v0, 4
    la $a0, msg_nfilas
    syscall
    li $v0, 5
    syscall
    move $t0, $v0 #$t0 almacena el nuevo número de filas 
    #Comprobamos que el número de filas es mayor que cero
    bgt $t0, $zero, iffin
        li $v0, 4
        la $a0, error_nfilas
        syscall
        jal mostrar_matriz
        b mostrar_menu

    iffin:  
      li $v0, 4
      la $a0, msg_ncols
      syscall
      li $v0, 5
      syscall
      move $t1, $v0 #$t1 almacena el nuevo número de columnas 

      #Comprobamos que el número de columnas es mayor que cero 
      bgt $t1, $zero, iffin2
          li $v0, 4
          la $a0, error_ncols
          syscall
          jal mostrar_matriz
          b mostrar_menu
    iffin2: 

      mul $t3, $t0, $t1 #Almacenamos en $t3 el número total de elementos
      li $t4, 400 #Almacenamos en $t4 el número máximo de elementos, para la comparación
  
    if: 
       bge $t4, $t3, redimensionamos
       li $v0, 4
       la $a0, error_dime
       syscall
       li $v0, 4
       la $a0, newline
       syscall
       jal mostrar_matriz
       b mostrar_menu

    redimensionamos: 
       sw $t0, nfil #Modificamos el número de filas 
       sw $t1, ncol #Modificamos el número de columnas
       jal mostrar_matriz
       b mostrar_menu


  obtener_elemento: 

    la $s0, mat #Almacenamos en $s0 la dirección base de la matriz

    lw $t0, nfil #Almacenamos en el registro temporal $t0 el número de filas
    lw $t1, ncol #Almacenamos en el registro temporal $t1 el número de columnas
 
    sub $t0, $t0, 1 #Almacenamos el número de filas menos uno, ya que contamos el primer índice desde cero
    sub $t1, $t1, 1 #Almacenamos el número de columnas menos uno, ya que contamos el primer índice desde cero

    #Recibimo la fila del elemento a obtener
    li $v0, 4
    la $a0, msg_i
    syscall
    li $v0, 5
    syscall
    move $t2, $v0 #Almacenamos en el registro $t2 la fila del elemento a obtener
    #Comprobamos que el número de la fila es correcto
    if_fila:
            bge $t0, $t2, if_fila1
            li $v0, 4
            la $a0, error_nfilas
            syscall
            jal mostrar_matriz
            b mostrar_menu
    if_fila1: 
            bge $t2, $zero, obtener_columna
            li $v0, 4
            la $a0, error_nfilas
            syscall
            jal mostrar_matriz
            b mostrar_menu
    
    obtener_columna: 
  
      li $v0, 4
      la $a0, msg_j
      syscall
      li $v0, 5
      syscall
      move $t3, $v0 #Almacenamos en el registro $t3 la columna del elemento a obtener


    #Comprobamos que el número de la columna también es correcto
    if_columna: 
             bge $t1, $t3, if_columna1
             li $v0, 4
             la $a0, error_ncols
             syscall
             jal mostrar_matriz
             b mostrar_menu
    if_columna1: 
             bge $t3, $zero, calcular_elemento
             li $v0, 4
             la $a0, error_ncols
             syscall
             jal mostrar_matriz
             b mostrar_menu

    calcular_elemento:        

      #Para obtener el elemento aplicamos la fórmula: (Fila_introducida * numero_columnas + 1) + columna_introducida

      addi $t1, 1 #Almacenamos en el registro $t1 el número de colunas + 1
      mul $t0, $t2, $t1 #Reutilizamos el registro $t0 y almacenamos la operación: (Fila_introducida * numero_columnas + 1)
      add $t4, $t3, $t0 #Almacenamos en el registro $t4 la posición del elemento

      li $t5, 4
      mul $t6, $t4, $t5 #Almacenamos en el registro $t6 la posición el elemento por 4 (tamaño de cada número)
      add $s0, $s0, $t6 #Actualizamos el valor de $s0, para apuntar al elemento deseado
      lw $t7, 0($s0) #Almacenamos en $t7 el número a mostrar
      
      #Mostramos el número
      li $v0, 4
      la $a0, msg_elemento
      syscall
      li $v0, 1
      move $a0, $t7
      syscall
      li $v0, 4
      la $a0, newline
      syscall
      jal mostrar_matriz
      b mostrar_menu


  invertir_fila: 

    #Almacenamos en el registro $t0 el número de filas 
    lw $t0, nfil
    sub $t0, $t0, 1 #Restamos uno al número total de filas, ya que contaremos como la primera fila el índice 0. 

    li $v0, 4
    la $a0, msg_f
    syscall
    li $v0, 5
    syscall
    move $t1, $v0 #Almacenamos en $t1 el índice de la fila a invertir
    #Comprobamos que el índice de la fila es correcto
    fila_correcta: 
      bge $t0, $t1, fila_correcta1 #Comprobamos que el número introducido sea menor o igual que el total de filas
      li $v0, 4
      la $a0, error_nfilas
      syscall
      jal mostrar_matriz
      b mostrar_menu

    fila_correcta1: 
      bge $t1, $zero, invertimos_fila
      li $v0, 4
      la $a0, error_nfilas
      syscall
      jal mostrar_matriz
      b mostrar_menu
  
    invertimos_fila: 
      
      la $s0, mat     #Guardamos en $a0 la dirección base de la matriz
      li $s1, 2       #Almacenamos un 2, para las operaciones. 
      li $s2, 4       #Almacenamos un 4, para las operaciones. 

      lw $t3, ncol #Almacenamos en $t3 el número de columnas. 
                   #De esta manera, el primer elemento de la fila será fila_introducida * numero_columnas.

      mul $t4, $t1, $t3 
      mul $t4, $t4, 4  #Aquí encontramos el primer elemento de la fila
      add $s0, $s0, $t4 #Apuntamos al primer elemento de la fila 
      
    
      #Reutilizamos $t4 
      div $t4, $t3, $s1 #Almacenamos en $t4 el número de columnas entre 2, ya que en cada iteración invetiremos dos
                        #elementos, por lo que solo necesito hacer (ncols / 2) iteraciones

      sub $t3, $t3, 1 #Guardamos el número de filas menos uno, para poder recorrer bien la fila. 
      
      move $t2, $zero #Inicializamos $t2 a cero, a modo de contador

      #$t2 = contador, $t3 = Número de filas - 1, $t4 = número de columnas / 2, 

      for_invertir_fila: 
        bge $t2, $t4, finfor #Desde que el contador sea mayor o igual que el número de columnas / 2 terminamos for.
        lw $t5, 0($s0)    #Almacenamos en $t5, el elemento al que apuntamos 

        mul $t6, $t2, 2   #$t6 almacena contador * 2
        sub $t6, $t3, $t6 #Alamacenamos en $t6 el número de columnas menos el doble del contador. 
                          #De este modo, almacenamos en $t6 el número de posiciones que debemos avanzar para almacenar $t5. 
                          #Es necesario restar al número de columnas el DOBLE del contador, porque si no siempre apuntaremos al elemento final de la fila, ya
                          #que avanzamos según la recorremos. 
                          
        mul $t6, $t6, $s2 #Multiplicamos el número de posiciones por el tamaño de cada elemento (4) 
                           
        add $s0, $s0, $t6 #Así al sumar a $s0 el registro $t6 apuntamos al elemento donde queremos guardar $t5.
        lw $t7, 0($s0)    #Almacenamos en el registro $t7 el valor que invertiremos con $t5 
        sw $t5, 0($s0)    #Almacenamos $t5 en su posición invertia
        sub $s0, $s0, $t6 #Restamos a $s0 $t6, para volver a apuntar a $t5 
        sw $t7,0($s0)     #Almacenamos $t7 en la posición invertida

        addi $s0, 4        #Aumentamos en 4 el reigstro $s0, para apuntar al siguiente elemento
        addi $t2, 1        #Aumentamos en 1 el contador del programa
        b for_invertir_fila 
        
      finfor: 
    
        jal mostrar_matriz
        b mostrar_menu



  invertir_columna: 

    lw $t0, ncol 
    sub $t0, $t0, 1 #Almacenamos en el registro temporal $t0 el número columnas menos uno, únicamente para la comprobación. 

    li $v0, 4
    la $a0, msg_c
    syscall
    li $v0, 5 
    syscall
    move $t1, $v0 #Almacenamos en $t1 la columna introducida por el usuario. 

    bge $t0, $t1, if_columna_positiva #Comprobamos que la columna introducida es menor o igual al número columnas menos 1
    li $v0, 4
    la $a0, error_ncols
    syscall
    jal mostrar_matriz
    b mostrar_menu

    if_columna_positiva: 
      bge $t1, $zero, invertimos_columna #Comprobamos que la columna introducida es mayor o igual a 0
      li $v0, 4
      la $a0, error_ncols
      syscall
      jal mostrar_matriz
      b mostrar_menu

    invertimos_columna: 
      
      #Para saber con que elemento debemos invertir cada elemento de la columna, aplicamos la fórmula: 
      # fabs((nº filas - 1) - 2*contador)) * nºcolumnas. Es importante restar el DOBLE del contador, 
      # ya que en cada iteración nos aproximamos el doble al elemento con el que invertir. 

      addi $t0, 1 #Volvemos a almacenar el número de columnas real, para implementar el algoritmo.
      
      la $s0, mat #Almacenamos en el registro $s0 la dirección base de la matriz. 
      li $s1, 4   #Almacenamos un 4(tamaño de cada elemento) para las operaciones.
      li $s2, 2   #Almacenamos un 2, para las operaciones. 
      mul $s3, $t0, $s1 #Almacenamos en $s3 nº col * 4, para apuntar al siguiente elemento de la columna en cada iteración. 

      mul $t1, $t1, $s1 
      add $s0, $s0, $t1 #Apuntamos al primer elemento de la columna.
       
      lw $t1, nfil #Reutilizamos el registro $t1, para almacenar el número de filas.

      div $t2, $t1, $s2 #Almacenamos el número de filas / 2, ya que son el númer de iteraciones que 
                        #necesitamos hacer, al invertir dos elementos de la columnas por iteración. 

      sub $t1, 1 #Almacenamos el número de filas menos uno, para implementar el algoritmo. 
      li $t3, 0 #Inicializamos a 0, para usarlo como contador. 

      #$t0 = Número de columnas, $t1 = Número de filas - 1, $t2 = Número de filas / 2, $t3 = contador

      for_invertir_columna: 
        bge $t3, $t2, fin_invertir_columna
        lw $t4, 0($s0) #Tenemos en $t4 el elemento de la columna a invertir. 
        #Para encontrar el elemento con el que invertir $t4: fabs((nº filas - 1) - 2*contador)) * nºcolumnas
        mul $t5, $s2, $t3 #$t5 = 2*contador
        sub $t6, $t1, $t5 #$t6 = (nº filas - 1) - 2*contador)
        abs $t6, $t6 #$t6 = |$t6| 
        mul $t6, $t6, $t0 #Reutilizamos $t6 para almacenar el resultado final de la operación. 

        mul $t6, $t6, $s1 
        add $s0, $s0, $t6 #Apuntamos al elemento con el que invertir $t4 

        lw $t7, 0($s0) #Almacenamos el elemento con el que invertir $t4 
        sw $t4, 0($s0) #Invertimos el primer elemento 
        sub $s0, $s0, $t6
        sw $t7, 0($s0) #Invertimos el segundo elemento

        addi $t3, 1
        add $s0, $s0, $s3 #Apuntamos al siguiente elemento de la columna

        b for_invertir_columna

      fin_invertir_columna: 

        jal mostrar_matriz
        b mostrar_menu


  mostrar_matriz: 
      
      la $s0, mat #Almacenamos en $s0 la dirección base de la matriz
      move $t0, $zero #Inicializamos $t0 a cero, para realizar la búsqueda
      move $t1, $zero #Inicializamos $t1 a cero, para realizar la búsqueda

      lw $t5,nfil #$t5 almacena el número de filas que pasamos como parámetro
      lw $t6,ncol #$t6 almacena el número de columnas que pasamos como parámetro
      
      #Mostramos las dimensiones de la matriz
      li $v0, 4
      la $a0, header
      syscall
      li $v0, 1
      move $a0, $t5
      syscall
      li $v0, 4
      la $a0, x
      syscall
      li $v0, 1
      move $a0, $t6
      syscall
      li $v0, 4
      la $a0, newline
      syscall
      
      #$t0 = Contador  $t5 = Número de filas  $t6 = Número de columnas

      for: 
        
        bge $t0, $t5, fin_for

        for_fila: 

          bge $t1, $t6, fin_for_fila

          lw $t2, 0($s0) #Almaceno en $t2 el elemento a mostrar
          move $a0, $t2
          li $v0, 1
          syscall
          li $v0, 4
          la $a0, separador
          syscall

          addi $s0, 4 #Actualizo $s0, para apuntar al siguiente elemento
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
      jr $ra 

  fin: 
      li $v0, 4
      la $a0, msg_fin
      syscall
      li $v0, 10
      syscall

#Lunes.