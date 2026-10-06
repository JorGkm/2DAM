import 'dart:convert';
import 'dart:io';

import 'package:practicar_clase/usuario.class.dart';

void main() {
  final List<dynamic> datos =
      jsonDecode(File('bin/persona.json').readAsStringSync()) as List<dynamic>;
  final Usuario original =
      Usuario.fromJson(datos.first as Map<String, dynamic>);

  print("=== ORIGINAL ===");
  print(original);

  final String serializado = jsonEncode(original.toJson());
  print("\n=== toJson() serializado ===");
  print(serializado);

  final Usuario reconstruido =
      Usuario.fromJson(jsonDecode(serializado) as Map<String, dynamic>);
  print("\n=== fromJson(toJson(original)) ===");
  print(reconstruido);
}
