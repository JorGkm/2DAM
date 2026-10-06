import 'dart:math';

class TrianguloRectangulo {
  double cateto1;
  double cateto2;
  double hipotenusa;

  TrianguloRectangulo._(this.cateto1, this.cateto2, this.hipotenusa);

  factory TrianguloRectangulo(double cateto1, double cateto2) {
    final hipotenusa = sqrt(pow(cateto1, 2) + pow(cateto2, 2));
    return TrianguloRectangulo._(cateto1, cateto2, hipotenusa);
  }

  void mostrarInfo() {
    print('Cateto1: ${cateto1.toStringAsFixed(2)}');
    print('Cateto2: ${cateto2.toStringAsFixed(2)}');
    print('Hipotenusa: ${hipotenusa.toStringAsFixed(2)}');
  }
}
