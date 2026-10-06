/*
Tendrá las siguientes propiedades no nulables: id (numero), username (cadena), password (cadena) y email (cadena).
Tendrá las siguientes propiedades nulables: nombre (cadena), apellidos (cadena) y nacionalidad (cadena).
*/

import 'package:ejemplosdart/ubicacion.class.dart';

class Usuario {
  int id;
  String username;
  String password;
  String email;

  String? nombre;
  String? apellidos;
  String? nacionalidad;

  final List<String> coloresFavoritos;
  final List<Ubicacion> lugaresFavoritos;

  /*Implementa un getter nombreCompleto, que devuelve el resultado de concatenar el nombre y los apellidos del usuario en una sola cadena.*/
  String get nombreCompleto => "$nombre $apellidos";

  /*
  Todas las propiedades se inicializarán a través del constructor de la clase. En él, id, username, password y email serán parámetros con nombre obligatorios, mientras que nombre, apellidos y nacionalidad serán parámetros con nombre opcionales.
  */
  Usuario({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    this.nombre,
    this.apellidos,
    this.nacionalidad,
    List<String>? coloresFavoritos,
    List<Ubicacion>? lugaresFavoritos,
  }) : coloresFavoritos = coloresFavoritos ?? [],
       lugaresFavoritos = lugaresFavoritos ?? [];

  /*
  Implementa un método toString() que devuelva una cadena de texto con todos los datos del usuario, convenientemente formateados (por ahora ignoramos la fecha de nacimiento). Usa interpolación de cadenas. La cadena devuelta será similar a la siguiente:

  Usuario(
    Id: 1
    Username: jaimeruiz
    Password: 1234
    Email: jaimeruiz@iesportada.org
    Nombre: Jaime
    Apellidos: Ruiz Medina
    Nacionalidad: España
  )
  */
  @override
  String toString() {
    return [
      "Usuario(",
      [
        "Id: $id",
        "Username: $username",
        "Password: $password",
        "Email: $email",
        if (nombre != null) "Nombre: $nombre",
        if (apellidos != null) "Apellidos: $apellidos",
        if (nacionalidad != null) "Nacionalidad: $nacionalidad",
        if (coloresFavoritos.isNotEmpty)
          "Colores Favoritos: ${coloresFavoritos.join(", ")}",
        if (lugaresFavoritos.isNotEmpty)
          "LugaresFavoritos: ${lugaresFavoritos.join(", ")}",
      ].map((e) => "  $e").join("\n"),
      ")",
    ].join("\n");
  }

  Usuario copyWith({
    int? id,
    String? username,
    String? password,
    String? email,
    String? nombre,
    String? apellidos,
    String? nacionalidad,
    List<String>? coloresFavoritos,
    List<Ubicacion>? lugaresFavoritos,
  }) => Usuario(
    id: id ?? this.id,
    username: username ?? this.username,
    password: password ?? this.password,
    email: email ?? this.email,
    nombre: nombre ?? this.nombre,
    apellidos: apellidos ?? this.apellidos,
    nacionalidad: nacionalidad ?? this.nacionalidad,
    coloresFavoritos: (coloresFavoritos ?? this.coloresFavoritos).toList(),
    lugaresFavoritos: List.from(
      (lugaresFavoritos ?? this.lugaresFavoritos).map(
        (lugar) => lugar.copyWith(),
      ),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "password": password,
    "email": email,
    if (nombre != null) "nombre": nombre,
    if (apellidos != null) "apellidos": apellidos,
    if (nacionalidad != null) "nacionalidad": nacionalidad,
    if (coloresFavoritos.isNotEmpty)
      "coloresFavoritos": List.from(coloresFavoritos),
    if (lugaresFavoritos.isNotEmpty)
      "lugaresFavoritos": lugaresFavoritos
          .map((lugar) => lugar.toJson())
          .toList(),
  };

  factory Usuario.fromJson(Map<String, dynamic> datos) => Usuario(
    id: datos["id"],
    username: datos["username"],
    password: datos["password"],
    email: datos["email"],
    nombre: datos["nombre"],
    apellidos: datos["apellidos"],
    nacionalidad: datos["nacionalidad"],
    coloresFavoritos: datos["coloresFavoritos"] != null
        ? List.from(datos["coloresFavoritos"])
        : null,
    lugaresFavoritos: datos["lugaresFavoritos"] != null
        ? List.from(datos["lugaresFavoritos"])
              .map((datosLugar) => Ubicacion.fromJson(datosLugar))
              .toList()
        : null,
  );
}
