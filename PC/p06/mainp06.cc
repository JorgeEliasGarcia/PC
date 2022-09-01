#include <iostream>

#include "p06.cc"
#include "p06.h"

int MostrarMenu() {
  std::cout << "\n(1) Cambiar dimensiones\n(2) Obtener elemento [i,j]\n"
               "(3) Invertir fila\n(4) Invertir columna\n(5) Traspuesta\n(0) Salir\nElija opcion: ";
  int opcion_elegida;
  std::cin >> opcion_elegida;
  return opcion_elegida;
}

int main() {
  std::cout << "Práctica 5 de Principio de Computadores. Matrices" << std::endl;
  matrix_t<int> matriz;
  matriz.rellenar_matriz();
  int opcion;
  int elemento;

  do {
    matriz.Escribir();
    opcion = MostrarMenu();
    switch (opcion) {
      case 1:
        matriz.Redimensionar();
        break;

      case 2:
        elemento = matriz.RetornarElemento();
        if (elemento != -1) {
          std::cout << elemento << std::endl;
        }
        break;

      case 3:
        matriz.InvertirFila();
        break;

      case 4:
        matriz.InveretirColumna();
        break;
      case 5: 
        if (matriz.get_m() != matriz.get_n()) {
            std::cerr << "\nError: No se puede calcular la traspuesta en matrices no cuadradas.\n"; 
            break; 
        } else {
            matriz.Traspuesta(); 
            break; 
        }

      default:
        break;
    }
  } while (opcion != 0);

  return 0;
}