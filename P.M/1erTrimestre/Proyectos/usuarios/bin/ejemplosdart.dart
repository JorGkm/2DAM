import 'package:ejemplosdart/usuario.class.dart';

void main(List<String> arguments) {
  List<int> numeros = [1, 2, 3, 4, 5];

  // Usando el operador en cascada para realizar múltiples operaciones en 'numeros'
  var resultado = numeros.map((e) => e - 1).toList()
    ..add(6)
    ..addAll([7, 8, 9])
    ..map((e) => e - 1)
    ..remove(3)
    ..fold<int?>(
      null,
      (int? valor, actual) =>
          valor == null ? actual : (valor >= actual ? valor : actual),
    );

  print(resultado); // Salida: [1, 2, 4, 5, 6, 7, 8, 9]

  /*
  Crea, a modo de ejemplo, un objeto de la clase Usuario con datos diferentes a los del ejemplo, y muéstralo por la consola.
  */
  Usuario user = Usuario(
    id: 1,
    username: "paco",
    password: "1234",
    email: "paco@gmail.com",
    nombre: "Paco",
  );

  print(user);

  Usuario otro = user.copyWith(username: "miguel", nombre: "Miguel");

  print(otro);

  Map<String, Object> datosPrincipales = {
    "id": 1,
    "username": "paco",
    "password": "1234",
    "email": "paco@gmail.com",
    "nombre": "Paco",
    "apellidos": "Martín",
    "nacionalidad": "Española",
  };

  Map<String, dynamic> datosAmpliados = {
    ...datosPrincipales,
    "coloesFavoritos": ["verde", "azul"],
    "lugaresFavoritos": [
      {"nombre": "Málaga", "fechaUltimaVisita": "2025-08-12"},
    ],
  };

  var unUsuario = Usuario.fromJson({
    "id": 1,
    "username": "paco",
    "password": "1234",
    "email": "paco@gmail.com",
    "nombre": "Paco",
    "apellidos": "Martín",
    "nacionalidad": "Española",
    "coloresFavoritos": ["verde", "azul"],
    "lugaresFavoritos": [
      {"nombre": "Málaga", "fechaUltimaVisita": "2025-08-12"},
      {"nombre": "Almería", "fechaUltimaVisita": "2025-07-12"},
    ],
  });

  print(unUsuario);
}
