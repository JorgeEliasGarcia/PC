
# Autores: Jorge Elías García y José Ramón Morera Campos
# Fecha: 13 de mayo de 2022

###################
#   PSEUDOCÓDIGO  #
###################

# El preudocódigo se encuentra dividido en: main.cc(programa principal), matrix_t.h(declaración de la
# clase matrix_t) y matrix_t.cc(contiene las definiciones de la clase matrix_t)

# main.cpp:


#include <iostream>

#include "matrix_t.cpp"
#include "matrix_t.h"

# int MostrarMenu() {
#   std::cout << "\n(1) Cambiar dimensiones\n(2) Obtener elemento [i,j]\n"
#                "(3) Invertir fila\n(4) Invertir columna\n(5) Traspuesta\n(0) Salir\nElija opcion: ";
#   int opcion_elegida;
#   std::cin >> opcion_elegida;
#   return opcion_elegida;
# }

# int main() {
#   std::cout << "Práctica 6 de Principio de Computadores. Matrices" << std::endl;
#   matrix_t<int> matriz;
#   matriz.rellenar_matriz();
#   int opcion;
#   int elemento;

#   do {
#     matriz.PrintMatriz();
#     opcion = MostrarMenu();
#     switch (opcion) {
#       case 0:
#         break;

#       case 1:
#         matriz.Redimensionar();
#         break;

#       case 2:
#         elemento = matriz.RetornarElemento();
#         if (elemento != -1) {
#           std::cout << elemento << std::endl;
#         }
#         break;

#       case 3:
#         matriz.InvertirFila();
#         break;

#       case 4:
#         matriz.InveretirColumna();
#         break;

#       case 5:
#         if (matriz.get_m() != matriz.get_n()) {
#           std::cerr << "\nError: No se puede calcular la traspuesta en matrices no cuadradas.\n";
#           break;
#         } else {
#           matriz.Traspuesta();
#           break;
#         }

#       default:
#         std::cout << "\nError: opcion incorrecta.\n";
#     }
#   } while (opcion != 0);

#   return 0;
# }

# matrix_t.h: 
#pragma once

#include <cassert>
#include <iostream>
#include <vector>

# using namespace std;

# template <class T>
# class matrix_t {
#  public:
#   matrix_t(const int = 0, const int = 0);
#   void rellenar_matriz();
#   void Redimensionar();
#   void InvertirFila();
#   void InveretirColumna();
#   int RetornarElemento() const;
#   void Traspuesta();

#   // getters
#   int get_m(void) const { return m_; };
#   int get_n(void) const { return n_; };

#   void PrintMatriz(ostream& = cout) const;

#  private:
#   int m_, n_;  // m_ filas y n_ columnas
#   vector<T> v_;
#   // Esta es una función fundamental del programa, pues recibiendo dos enteros, como si fuesen las
#   // posiciones de la matriz (SIN CONTAR INDICES CERO), accede a la posición indicada del vector
#   // aplicando la fórmula: (i - 1) * get_n() + (j - 1), siendo i la fila, j la columna y get_n()
#   // número de columnas.
#   int pos(const int, const int) const;
# };

# matrix_t.cc:

# include "matrix_t.h"

# // Constructor de la clase matrix_t
# template <class T>
# matrix_t<T>::matrix_t(const int m, const int n) {
#   m_ = m;
#   n_ = n;
#   v_.resize(m_ * n_);
# }

# template <class T>
# void matrix_t<T>::PrintMatriz(ostream& os) const {
#   os << "\nMatriz con dimensiones: ";
#   os << get_m() << "x" << get_n() << endl;
#   for (int i = 1; i <= get_m(); ++i) {
#     for (int j = 1; j <= get_n(); ++j) os << v_[pos(i, j)] << "\t";
#     os << endl;
#   }
#   os << endl;
# }

# // Función que intercambia los contenidos de dos punteros
# template <class T>
# void swap(T* a, T* b) {
#   T aux{*a};
#   *a = *b;
#   *b = aux;
# }

# /* Función recursiva que invierte filas o columnas
#  El primer argumento es la dirección de memoria del primer elemento de la fila o columna a invertir.
#  El segundo argumento es el número de elementos que tiene la fila o la columna.
#  El tercer argumento es la distancia existente entre un elemento y el siguiente en la fila o
#  columna */
# void invertir(int* dir, const unsigned elementos, const unsigned distancia) {
#   // caso trivial
#   if (elementos <= 1) {
#     return;
#   } else {
#     // Realizamos el intercambio entre los elementos de los extremos
#     // Calculamos la dirección del elemento final del intercambio
#     int* dir_final{dir};
#     unsigned desplazamiento{elementos - 1};
#     desplazamiento *= distancia;
#     dir_final += desplazamiento;

#     swap(dir, dir_final);

#     // Llamada recursiva:
#     // Movemos la dirección hasta el siguiente elemento a intercambiar y
#     // disminuimos en 2 el número de elemenots
#     invertir(dir + distancia, elementos - 2, distancia);

#     return;
#   }
# }

# // Esta es una función fundamental del programa, pues recibiendo dos enteros, como si fuesen las
# // posiciones de la matriz (EMPEZANDO A CONTAR DESDE EL 1,1), accede a la posición indicada del
# // vector aplicando la fórmula: (i - 1) * get_n() + (j - 1), siendo i la fila, j la columna y
# // get_n() número de columnas.
# template <class T>
# inline int matrix_t<T>::pos(const int i, const int j) const {
#   assert(i > 0 && i <= get_m());
#   assert(j > 0 && j <= get_n());
#   return (i - 1) * get_n() + (j - 1);
# }

# template <class T>
# void matrix_t<T>::rellenar_matriz() {
#   v_.resize(200);
#   m_ = 20;
#   n_ = 10;
#   for (int i{0}; i < 200; ++i) {
#     v_[i] = 100 + i;
#   }
# }

# template <class T>
# void matrix_t<T>::Redimensionar() {
#   std::cout << "\nIntroduzca numero de filas: ";
#   int m;
#   std::cin >> m;
#   if (m > 20 || m < 0) {
#     std::cerr << "\nError: dimension incorrecta. Numero de fila incorrecto.\n";
#     return;
#   }

#   std::cout << "\nIntroduzca número de columnas: ";
#   int n;
#   std::cin >> n;
#   if (n > 10 || n < 0) {
#     std::cerr << "\nError: dimension incorrecta. Numero de columna incorrecto.\n";
#     return;
#   }
#   m_ = m, n_ = n;
# }

# template <class T>
# int matrix_t<T>::RetornarElemento() const {
#   std::cout << "\nObtener el elemento [i,j]. Introduzca indice i (primera fila indice 0): ";
#   int fila;
#   std::cin >> fila;
#   if (fila > get_m() - 1 || fila < 0) {
#     std::cerr << "\nError: dimension incorrecta. Numero de fila incorrecto.\n";
#     return -1;
#   }
#   std::cout << "\nObtener el elemento [i,j]. Introduzca indice j (primera columna indice 0): ";
#   int columna;
#   std::cin >> columna;
#   if (columna > get_n() - 1 || columna < 0) {
#     std::cerr << "\nError: dimension incorrecta. Numero de fila columna.\n";
#     return -1;
#   }

#   return v_[pos(fila + 1, columna + 1)];
# }

# template <class T>
# void matrix_t<T>::InvertirFila() {
#   std::cout << "\nInvertir la fila [i,*]. Introduzca indice i (primera fila indice 0): ";
#   int fila;
#   std::cin >> fila;
#   if (fila > get_m() - 1 || fila < 0) {
#     std::cerr << "\nError: dimension incorrecta. Numero de fila incorrecto.\n";
#     return;  // Salimos de la función sin modificar la fila, al no ser válida.
#   }
#   invertir(&v_[get_m() * fila], get_n(), 1);
# }

# template <class T>
# void matrix_t<T>::InveretirColumna() {
#   std::cout << "\nInvertir la columna [*,j]. Introduzca indice j (primera fila indice 0): ";
#   int columna;
#   std::cin >> columna;
#   if (columna > get_n() - 1 || columna < 0) {
#     std::cerr << "\nError: dimension incorrecta. Numero de columna incorrecto.\n";
#     return;  // Salimos de la función sin modificar la columna, al no ser válida.
#   }
#   invertir(&v_[columna], get_m(), get_n());
# }

# template <class T>
# void matrix_t<T>::Traspuesta() {
#   for (int i{1}; i < get_m(); ++i) {
#     for (int j{1 + i}; j <= get_m(); ++j) {
#       swap(&v_[pos(i, j)], &v_[pos(j, i)]);
#     }
#   }
# }


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
       

nfil:   .word   20 # numero de filas de la matriz
ncol:   .word   10 # numero de columnas de la matriz
separador:  .asciiz "  " # separador entre numeros
newline:    .asciiz "\n"
menu:       .ascii  "\n(1) Cambiar dimensiones\n(2) Obtener elemento [i,j]\n"
            .asciiz "(3) Invertir fila\n(4) Invertir columna\n(5) Traspuesta\n(0) Salir\nElija opcion: "
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
titulo:     .asciiz "\nPractica 6 de Principios de Computadores. Matrices con funciones.\n"
header:     .asciiz "Matriz con dimension "
x:          .asciiz " x "
msg_fin:    .asciiz "\nFin del programa.\n"
error_no_cuadrada:  .asciiz "\nError: No se puede calcular la traspuesta en matrices no cuadradas.\n"

    
    .text
main:

  li        $v0, 4
  la        $a0, titulo
  syscall 
  li        $v0, 4
  la        $a0, newline
  syscall

  etiqueta_do_info: 

    la      $a1, mat  # Cargamos en $a1 la dirección base de la matriz a imprimir.  
    lw      $a2, nfil # Cargamos en $a2 el número de filas. 
    lw      $a3, ncol # Cargamos en $a3 el número de columnas 

    # std::cout << "Matriz con dimension " << nfil << " x " << ncol << endl;
    li      $v0, 4
    la      $a0, header
    syscall

    li      $v0, 1    
    lw      $a0, nfil 
    syscall

    li      $v0, 4
    la      $a0, x
    syscall
        
    li      $v0, 1
    lw      $a0, ncol 
    syscall

    li      $v0, 4
    la      $a0, newline
    syscall

    # Imprimimos los elementos de la matriz
    jal     print_matriz

    mostrar_menu: 

      # Mostramos el menu
      la      $a0, menu
      li      $v0, 4
      syscall
      # Recibimos el la opción elegida 
      li      $v0, 5
      syscall

      move    $t0, $v0                     # Almacenamos en $t0 el número introducido en el menú
      beq     $t0, 0, fin                  # Si número introducido es igual a 0, terminamos programa
      beq     $t0, 1, cambiar_dimensiones  
      beq     $t0, 2, obtener_elemento
      beq     $t0, 3, invertir_fila
      beq     $t0, 4, invertir_columna
      beq     $t0, 5, traspuesta_assert

      # En caso de escribir una opcion incorrecta, mostramos el mensaje de error y de nuevo el menu
      la      $a0, error_op
      li      $v0, 4
      syscall
      b       etiqueta_do_info

  cambiar_dimensiones: 

    li      $v0, 4
    la      $a0, msg_nfilas
    syscall
    li      $v0, 5
    syscall
    move    $t0, $v0 # $t0 almacena el nuevo número de filas 

    # Comprobamos que el número de filas es mayor que cero
    bgt     $t0, $zero, else

    li      $v0, 4
    la      $a0, error_nfilas
    syscall
    
    b       etiqueta_do_info

    else:  
      li      $v0, 4
      la      $a0, msg_ncols
      syscall
      li      $v0, 5
      syscall
      move    $t1, $v0 # $t1 almacena el nuevo número de columnas 

      # Comprobamos que el número de columnas es mayor que cero 
      bgt     $t1, $zero, else2
      li      $v0, 4
      la      $a0, error_ncols
      syscall

      b       etiqueta_do_info

      else2: 
        mul     $t2, $t0, $t1 # Almacenamos en $t3 el número total de elementos

        # Comprobamos las dimensiones
        if: 
          ble     $t2, maximoElementos, redimensionamos
          li      $v0, 4
          la      $a0, error_dime
          syscall
          li      $v0, 4
          la      $a0, newline
          syscall

          b       etiqueta_do_info

        redimensionamos: 
          sw      $t0, nfil # Modificamos el número de filas 
          sw      $t1, ncol # Modificamos el número de columnas

          b       etiqueta_do_info


  obtener_elemento: 
    la      $s0, mat    # Almacenamos en $s0 la dirección base de la matriz

    lw      $t0, nfil   # Almacenamos en el registro temporal $t0 el número de filas
    lw      $t1, ncol   # Almacenamos en el registro temporal $t1 el número de columnas
 
    sub     $t0, $t0, 1 # Almacenamos el número de filas menos uno, ya que contamos el primer índice desde cero
    sub     $t1, $t1, 1 # Almacenamos el número de columnas menos uno, ya que contamos el primer índice desde cero

    # Recibimo la fila del elemento a obtener
    li      $v0, 4
    la      $a0, msg_i
    syscall
    li      $v0, 5
    syscall
    move    $t2, $v0    # Almacenamos en el registro $t2 la fila del elemento a obtener

    # Comprobamos que el número de la fila es correcto
    bge     $t2, $zero, fila_positiva
    
    li      $v0, 4
    la      $a0, error_nfilas
    syscall

    b       etiqueta_do_info

    fila_positiva: 
      bge     $t0, $t2, obtener_columna
      li      $v0, 4
      la      $a0, error_nfilas
      syscall

      b       etiqueta_do_info
    
    obtener_columna: 
      li      $v0, 4
      la      $a0, msg_j
      syscall
      li      $v0, 5
      syscall
      move    $t3, $v0 # Almacenamos en el registro $t3 la columna del elemento a obtener

    # Comprobamos que el número de la columna también es correcto
      bge      $t3, $zero, columna_positiva
      li       $v0, 4
      la       $a0, error_ncols
      syscall

      b        etiqueta_do_info

      columna_positiva: 
        bge     $t1, $t3, calcular_elemento
        li      $v0, 4
        la      $a0, error_ncols
        syscall
        
        b       etiqueta_do_info

    calcular_elemento:        

      # Para obtener el elemento aplicamos la fórmula: (Fila_introducida * numero_columnas + 1) + columna_introducida
      addi    $t1, 1         # Almacenamos en el registro $t1 el número de columnas + 1
      mul     $t0, $t2, $t1  # Reutilizamos el registro $t0 y almacenamos la operación: (Fila_introducida * numero_columnas + 1)
      add     $t4, $t3, $t0  # Almacenamos en el registro $t4 la posición del elemento

      mul     $t6, $t4, size # Almacenamos en el registro $t6 la posición el elemento por el tamaño de cada elemento
      add     $s0, $s0, $t6  # Actualizamos el valor de $s0, para apuntar al elemento deseado
      lw      $t7, 0($s0)    # Almacenamos en $t7 el número a mostrar
      
      # Mostramos el número
      li      $v0, 4
      la      $a0, msg_elemento
      syscall
      li      $v0, 1
      move    $a0, $t7
      syscall
      li      $v0, 4
      la      $a0, newline
      syscall
      
      b       etiqueta_do_info


  invertir_fila: 

    #Almacenamos en el registro $t0 el número de filas 
    lw      $t0, nfil
    sub     $t0, $t0, 1 # Restamos uno al número total de filas, ya que contaremos como la primera fila el índice 0. 

    li      $v0, 4
    la      $a0, msg_f
    syscall
    li      $v0, 5
    syscall
    move    $t1, $v0    # Almacenamos en $t1 el índice de la fila a invertir

    # Comprobamos que el índice de la fila es correcto
    bge     $t0, $t1, fila_correcta # Comprobamos que el número introducido sea menor o igual que el total de filas
    li      $v0, 4
    la      $a0, error_nfilas
    syscall
      
    b       etiqueta_do_info

    fila_correcta: 
      bge     $t1, $zero, invertimos_fila
      li      $v0, 4
      la      $a0, error_nfilas
      syscall
      
      b etiqueta_do_info
  
    invertimos_fila: 
      
      la      $s0, mat       # Guardamos en $s0 la dirección base de la matriz

      lw      $t3, ncol      # Almacenamos en $t3 el número de columnas. 
                             # De esta manera, el primer elemento de la fila será fila_introducida * numero_columnas.

      mul     $t4, $t1, $t3  # $t4 = ncol * fila introducida
      mul     $t4, $t4, size # Hemos calculado el desplazamiento dentro de la matriz
      add     $a0, $s0, $t4  # Apuntamos al primer elemento de la fila con $a0

      move    $a1, $t3       # Guardamos ncol en $a1
      li      $a2, size      # Guardamos en $a2 la distancia en bytes entre cada elemento de la fila

      # Argumentos: $a0 = dir memoria inicial, $a1 = número de elementos de la fila, $a2 = distancia en bytes entre elementos
      jal     invertir
      
      b       etiqueta_do_info

  invertir_columna: 

    lw      $t0, ncol 
    sub     $t0, $t0, 1 # Almacenamos en el registro temporal $t0 el número columnas menos uno, únicamente para la comprobación. 

    li      $v0, 4
    la      $a0, msg_c
    syscall
    li      $v0, 5 
    syscall
    move    $t1, $v0    # Almacenamos en $t1 la columna introducida por el usuario. 

    bge     $t0, $t1, if_columna_positiva # Comprobamos que la columna introducida es menor o igual al número columnas menos 1
    li      $v0, 4
    la      $a0, error_ncols
    syscall
    
    b etiqueta_do_info

    if_columna_positiva: 
      bge     $t1, $zero, invertimos_columna # Comprobamos que la columna introducida es mayor o igual a 0
      li      $v0, 4
      la      $a0, error_ncols
      syscall
      
      b etiqueta_do_info

    invertimos_columna: 
      

      addi    $t0, 1        # Volvemos a almacenar el número de columnas real, para implementar el algoritmo.
      
      la      $s0, mat      # Almacenamos en el registro $s0 la dirección base de la matriz. 

      mul     $t1, $t1, size
      add     $a0, $s0, $t1 # Apuntamos al primer elemento de la columna.

      lw      $a1, nfil     # Cargamos nfil en $a1
      
      lw      $a2, ncol 
      mul     $a2, $a2, size # La distancia entre elementos de la misma columna es ncol *size

      # Argumentos: $a0 = dir memoria inicial, $a1 = número de elementos de la columna, $a2 = distancia en bytes entre elementos
      jal     invertir

      b       etiqueta_do_info
   
  traspuesta_assert: 

    la      $a1, mat  # Cargamos en el registro $a1 la dirección base de la matriz. 
    lw      $a2, nfil # Almacenamos en el registro $a2 el número de filas. 
    lw      $t0, ncol # Almacenamos en el registro temporal $t0 el número de columnas. 
    # Comprobamos que sea una matriz cuadrada.
    beq     $a2, $t0, fin_assert
    # En caso de no ser cuadrada, mostramos un error, la matriz y de nuevo el menú. 
    li      $v0, 4
    la      $a0, error_no_cuadrada
    syscall
    
    b       etiqueta_do_info

   fin_assert: 
    # En caso de que la matriz sea cuadrada, llamamos a la función traspuesta
    jal     traspuesta

    b       etiqueta_do_info # Volvemos a mostrar el menu   +

  fin: 
      li        $v0, 4
      la        $a0, msg_fin
      syscall
      li        $v0, 10
      syscall

#############
# Funciones #
#############

swap:   # Intercambia los contenidos de las direcciones almacenadas en $a1 y $a3
  lw    $t7, 0($a1)
  lw    $t6, 0($a3)

  sw    $t7, 0($a3)
  sw    $t6, 0($a1)

  jr    $ra  

print_matriz: # Imprime la matriz
  
  # Parámetros:
  # $a1 -> dirección base de la matriz a imprimir
  # $a2 -> número de filas 
  # $a3 -> número de columnas

  # Guardamos el valor de los registros salvados en la pila. 
  addiu     $sp, $sp, -12
  sw        $s0, 0($sp)
  sw        $s1, 4($sp)
  sw        $s2, 8($sp)

  
  move      $s0, $a1   # Empleamos $s0 para almacenar la posición actual
  move      $s1, $zero # Empleamos $s1 como contador de filas
  move      $s2, $zero # Empleamos $s2 como contador de columnas

  # Imprimimos los elementos de la matriz
  etiq_for_imprimir_matriz:

    # Cargamos e imprimimos el elemento. Recordemos que $s0 almacena la posición del elemento actual.
    lw      $t0, 0($s0)

    li      $v0, 1
    move    $a0, $t0
    syscall

    li      $v0, 4
    la      $a0, separador
    syscall

    addi    $s2, 1      # Incrementamos la columna
    addi    $s0, size   # Nos desplazamos en la matriz hacia el siguiente elemento

    # Si se acaba la fila, imprimimos un retorno de carro, reiniciamos la columna e incrementamos la fila
    bne     $a3, $s2, etiq_misma_fila
    
    li      $v0, 4
    la      $a0, newline
    syscall

    move    $s2, $zero
    addi    $s1, 1

  etiq_misma_fila:  
    # Terminamos cuando el número de filas impresas sea igual a nfil
    bne     $s1, $a2, etiq_for_imprimir_matriz

    li      $v0, 4
    la      $a0, newline
    syscall

  # Cargamos el valor de los registros salvados
  lw        $s0, 0($sp)
  lw        $s1, -4($sp)
  lw        $s2, -8($sp)

  # Equilibramos la pila
  addiu     $sp, $sp, -12

  jr $ra 
    

traspuesta:   # Calcula la matriz traspuesta
    
  # Almacenamos el valor de los registros salvados que usaremos en la pila
  addiu     $sp, $sp, -24
  sw        $ra, 0($sp)
  sw        $s0, 4($sp)
  sw        $s1, 8($sp)
  sw        $s2, 12($sp)
  sw        $s3, 16($sp)
  sw        $s4, 20($sp)

  # El registro $a1 contiene la dirección base de la matriz
  # El registro $a2 almacena número de filas = número de columnas. 
  mul       $s3, $a2, size # El registro $s3 almacena Nºcols * size

  addi      $a1, $a1, 4    # Apuntamos al primer elemento a invertir en la fila uno. 
  la        $a3, mat 
  add       $a3, $a3, $s3  # Apuntamos al primer elemento de invertir de la columna uno. 

  sub $s0, $a2, 1 # Almacenamos en el registro salvado $s0 el número de filas - 1, ya que lo usaremos mucho. 
    
  # Para conocer el número de iteraciones a realizar, aplicamos la fórmula: (Nºelementos - Nºfilas) / 2
  # Debido a que en cada iteración intercambiamos dos elementos, sin embargo los elementos de la diagonal
  # principal no se ven afectados, por ello tenemos que restar el número de elementos de la diagonal princial
  # al nº de elementos total. 
     
  mul     $s1, $a2, $a2  # Almacenamos el número total de elementos en el registro salvado $s1. 
  sub     $s1, $s1, $a2  # Almacenamos el número de elementos - número de filas.
  div     $s1, $s1, 2    # $s1 = Número de iteraciones. 
    
  move    $t0, $zero     # Cargamos un cero para usarlo a modo de contador. 
  move    $t1, $zero     # Ponemos el registro $t1 a cero para reutilizarlo a modo de contador. 
    
  # $a1 --> Apunta a los elementos de la fila. 
  # $a3 --> Apunta a los elementos de la columna. 
  mul     $s5, $a2, -1 # Almacenamos en $s5 -nºcols, para operaciones posteriores. 

  move    $t0, $zero # Cargamos un cero para el bucle. 

  for_traspuesta_1: 
    bge     $t0, $s0, fin_for_traspuesta_1
    sub     $t2, $s0, $t0  # $t2 = (Nºfils - 1) - $t0, esto será el número de iteraciones del segundo for. 
    # En este segundo for invertiremos los elementos que se encuentran separados por la diagonal principal, 
    # de tal manera que el primer recorrido de este bucle invertirá los elementos de la primer fila, el segundo la segunda fila..etc. 
    for_traspuesta_2: 
      bge       $t1, $t2, fin_for_traspuesta_2

      # Invertimos los elementos
      jal       swap
      add       $a1, $a1, size  # Apuntamos al siguiente elemento de la fila. 
      add       $a3, $a3, $s3   # Apuntamos al siguiente elemento de la columna.
          
      addi      $t1, 1
      b         for_traspuesta_2

    fin_for_traspuesta_2: 
      sub $a1, $a1, size # Volvemos a apuntar al elemento anterior, para poder seguir el algoritmo. 
      sub $a3, $a3, $s3  # Volvemos a apuntar al elemento anterior, para poder seguir el algoritmo. 

      # $a1 apuntará al siguiente elemento de la fila de abajo, por lo que sumaremos al registro $a1
      # 3 + $t0. (siempre será 3, ya que tenemos que pasar por el primer elemento de la columna inferior
      # y por el elemento de la diagonal principal. 
      addi    $t3, $t0, 3
      mul     $t3, $t3, size 
      add     $a1, $a1, $t3
      # $a3 apuntará al siguiene elemento de la columna siguiente. 
      # Para ello, apuntará a (-Nºcols) * [Nºfilas - 3 - $t0] + 1, de este modo al hacer el corchete determinaremos
      # cuantas columnas retroceder multiplicamos por el número de elementos por columna 
      # y sumamos 4 para acceder al elemento siguiente
      sub     $t4, $a2, 3
      sub     $t4, $t4, $t0
      mul     $t4, $t4, $s5 
      addi    $t4, 1
      mul     $t4, $t4, size
      add     $a3, $a3, $t4

      move    $t1, $zero # Volvemos a iniciar el contador a cero. 
      addi    $t0, 1
      b       for_traspuesta_1
      
  fin_for_traspuesta_1: 
    
    # Volvemos a cargar los registros que habíamos almacenado y equilibramos la pila
    lw      $ra, 0($sp)
    lw      $s0, 4($sp)
    lw      $s1, 8($sp)
    lw      $s2, 12($sp)
    lw      $s3, 16($sp)
    lw      $s4, 20($sp)

    addiu   $sp, $sp, 24
    jr      $ra           # Regresamos a donde la función fue llamada. 


  # Función recursiva que invierte filas o columnas
  # Toma tres argumentos, para los que empleamos los registros $a0, $a1 y $a2
  # El primer argumento es la dirección de memoria del primer elemento de la fila o columna a invertir.
  # El segundo argumento es el número de elementos que tiene la fila o la columna. 
  # El tercer argumento es el número de bytes existente entre un elemento y el siguiente en la fila o columna 
invertir:

  # Caso trivial, tenemos 1 solo elemento o menos
  bgt     $a1, 1, notrivial 
  jr      $ra

  notrivial:

    # Realizamos el intercambio entre los elementos de los extremos
    addi      $sp, $sp, -8  # reservamos espacio en la pila
    sw        $ra, 4($sp)   # almacenamos $ra
    sw        $a1, 0($sp)   # almacenamos $a1, que tiene que ser sobrescrito para llamar a swap

    move      $a3, $a0      # $a3 apunta al primer elemento a intercambiar
    addi      $a1, -1       # Empleamos $t0 como registro auxiliar para calcular la posición del otro elemento
    mul       $a1, $a1, $a2 # Calculamos el desplazamiento
    add       $a1, $a0, $a1 # $a1 apunta al segundo elemento a intercambiar

    jal       swap

    add       $a0, $a0, $a2 # Movemos la dirección hasta el siguiente elemento a intercambiar 

    lw        $a1, 0($sp)   # Rescatamos $a1 de la pila
    addi      $a1, $a1, -2  # Disminuimos en 2 el número de elementos
    addi      $sp, $sp, 4   # Dejamos el puntero de la pila equilibrado

    jal       invertir      # Llamada recursiva

    lw        $ra, 0($sp)
    addi      $sp, $sp, 4   # Dejamos el puntero de la pila equilibrado

    # Volvemos al punto de llamada de la función
    jr        $ra

   