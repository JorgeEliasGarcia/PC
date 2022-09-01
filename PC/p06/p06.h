#pragma once

#include <cassert>
#include <iostream>
#include <vector>

using namespace std;

template <class T>
class matrix_t {
 public:
  matrix_t(const int = 0, const int = 0);
  void rellenar_matriz();
  void Redimensionar();
  void InvertirFila();
  void InveretirColumna();
  int RetornarElemento() const;
  void Traspuesta(); 

  // getters
  int get_m(void) const { return m_; };
  int get_n(void) const { return n_; };

  void Escribir(ostream& = cout) const;

 private:
  int m_, n_;  // m_ filas y n_ columnas
  vector<T> v_;
  // Esta es una función fundamental del programa, pues recibiendo dos enteros, como si fuesen las
  // posiciones de la matriz (SIN CONTAR INDICES CERO), accede a la posición indicada del vector
  // aplicando la fórmula: (i - 1) * get_n() + (j - 1), siendo i la fila, j la columna y get_n()
  // número de columnas.
  int pos(const int, const int) const;
};
