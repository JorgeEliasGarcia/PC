
#include "p05.h"

// Constructor de la clase matrix_t
template <class T>
matrix_t<T>::matrix_t(const int m, const int n) {
  m_ = m;
  n_ = n;
  v_.resize(m_ * n_);
}

template <class T>
void matrix_t<T>::Escribir(ostream& os) const {
  os << "\nMatriz con dimensiones: ";
  os << get_m() << "x" << get_n() << endl;
  for (int i = 1; i <= get_m(); ++i) {
    for (int j = 1; j <= get_n(); ++j) os << v_[pos(i, j)] << "\t";
    os << endl;
  }
  os << endl;
}

// Esta es una función fundamental del programa, pues recibiendo dos enteros, como si fuesen las
// posiciones de la matriz (EMPEZANDO A CONTAR DESDE EL 1,1), accede a la posición indicada del
// vector aplicando la fórmula: (i - 1) * get_n() + (j - 1), siendo i la fila, j la columna y
// get_n() número de columnas.
template <class T>
inline int matrix_t<T>::pos(const int i, const int j) const {
  assert(i > 0 && i <= get_m());
  assert(j > 0 && j <= get_n());
  return (i - 1) * get_n() + (j - 1);
}

template <class T>
void matrix_t<T>::rellenar_matriz() {
  v_.resize(200);
  bool encontrado = true;
  m_ = 20;
  n_ = 10;
  for (int i{0}; i < 200; ++i) {
    v_[i] = 100 + i;
  }
}

template <class T>
void matrix_t<T>::Redimensionar() {
  std::cout << "\nIntroduzca numero de filas: ";
  int m;
  std::cin >> m;
  if (m > 20 || m < 0) {
    std::cerr << "\nError: dimension incorrecta. Numero de fila incorrecto.\n";
    return;
  }

  std::cout << "\nIntroduzca número de columnas: ";
  int n;
  std::cin >> n;
  if (n > 10 || n < 0) {
    std::cerr << "\nError: dimension incorrecta. Numero de columna incorrecto.\n";
    return;
  }
  m_ = m, n_ = n;
}

template <class T>
int matrix_t<T>::RetornarElemento() const {
  std::cout << "\nObtener el elemento [i,j]. Introduzca indice i (primera fila indice 0): ";
  int fila;
  std::cin >> fila;
  if (fila > get_m() - 1 || fila < 0) {
    std::cerr << "\nError: dimension incorrecta. Numero de fila incorrecto.\n";
    return -1;
  }
  std::cout << "\nObtener el elemento [i,j]. Introduzca indice j (primera columna indice 0): ";
  int columna;
  std::cin >> columna;
  if (columna > get_n() - 1 || columna < 0) {
    std::cerr << "\nError: dimension incorrecta. Numero de fila columna.\n";
    return -1;
  }

  return v_[pos(fila + 1, columna + 1)];
}

template <class T>
void matrix_t<T>::InvertirFila() {
  std::cout << "\nInvertir la fila [i,*]. Introduzca indice i (primera fila indice 0): ";
  int fila;
  std::cin >> fila;
  if (fila > get_m() - 1 || fila < 0) {
    std::cerr << "\nError: dimension incorrecta. Numero de fila incorrecto.\n";
    return;  // Salimos de la función sin modificar la fila, al no ser válida.
  }
  // Como en cada iteración intercambiamos dos elementos únicamente necesitamos nºcol/2 iteraciones.
  int numero_interaciones = get_n() / 2;
  for (int i{1}, j{0}; j < numero_interaciones; ++i, ++j) {
    // Tenemos que sumar 1 a la fila, ya que nuestro método pos recibe los índices comenzando desde
    // el (1,1)
    int primer_elemento = v_[pos(fila + 1, i)];
    // Para obtener el elemento con el elemento a intercambiar el primer elemento empleamos la
    // fórmula: (fila, nºcols - contador), para lo que usamos j inicializada en cero.
    int segundo_elmento = v_[pos(fila + 1, get_n() - j)];
    v_[pos(fila + 1, i)] = segundo_elmento;
    v_[pos(fila + 1, get_n() - j)] = primer_elemento;
  }
}

template <class T>
void matrix_t<T>::InveretirColumna() {
  std::cout << "\nInvertir la columna [*,j]. Introduzca indice j (primera fila indice 0): ";
  int columna;
  std::cin >> columna;
  if (columna > get_n() - 1 || columna < 0) {
    std::cerr << "\nError: dimension incorrecta. Numero de columna incorrecto.\n";
    return;  // Salimos de la función sin modificar la columna, al no ser válida.
  }
  int numero_iteraciones = get_m() / 2;  // EL número de iteraciones será el número de filas entre
                                         // 2, ya que en cada iteración alternamos 2 elementos.
  for (int i{1}, j{0}; j < numero_iteraciones; ++i, ++j) {
    int primer_elemento = v_[pos(i, columna + 1)];
    // El elemento con el que intercambiar el elemento que estamos recorriendo se encuentra en la
    // misma columna pero su fila es el número de filas - contador.
    int segundo_elemento = v_[pos(get_m() - j, columna + 1)];
    v_[pos(i, columna + 1)] = segundo_elemento;
    v_[pos(get_m() - j, columna + 1)] = primer_elemento;
  }
}