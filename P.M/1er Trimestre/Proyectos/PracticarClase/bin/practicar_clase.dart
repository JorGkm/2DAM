void main(List<String> arguments) {
  List<int> numeros = [1, 2, 3, 4, 5];
  numeros
    ..add(6)
    ..addAll([7, 8, 9])
    ..remove(3);

  final maximo = numeros.fold<int?>(
    null,
    (int? valor, int actual) => (valor == null)
        ? actual
        : (valor >= actual)
        ? valor
        : actual,
  );

  print(numeros);
  print(maximo);
}
