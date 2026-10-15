import 'dart:convert';
import 'dart:io';

import 'package:practicar_clase/usuario.class.dart';

/// Lee el JSON con la lista de usuarios y la convierte en `List<Usuario>`.
List<Usuario> cargarUsuarios(String ruta) {
  final String contenido = File(ruta).readAsStringSync();
  final List<dynamic> datos = jsonDecode(contenido) as List<dynamic>;
  return datos
      .map((dato) => Usuario.fromJson(dato as Map<String, dynamic>))
      .toList();
}

void practicarNumeros() {
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