import 'package:practicar_clase/ubicacion.class.dart';

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

  String get nombreCompleto => "$nombre $apellidos";

  Usuario copyWith(
    int? id,
    String? username,
    String? password,
    String? email,
    String? nombre,
    String? apellidos,
    String? nacionalidad,
    List<String>? coloresFavoritos,
    List<Ubicacion>? lugaresFavoritos,
  ) => Usuario(
    id: id ?? this.id,
    username: username ?? this.username,
    password: password ?? this.password,
    email: email ?? this.email,
    nombre: nombre ?? this.nombre,
    apellidos: apellidos ?? this.apellidos,
    nacionalidad: nacionalidad ?? this.nacionalidad,
    coloresFavoritos: List.from(coloresFavoritos ?? this.coloresFavoritos),
    lugaresFavoritos: List.from(lugaresFavoritos ?? this.lugaresFavoritos),
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "password": password,
    "email": email,
    if (nombre != null) "nombre": nombre,
    if (apellidos != null) "apellidos": apellidos,
    if (nacionalidad != null) "nacionalidad": nacionalidad,
    if (coloresFavoritos.isNotEmpty) "colores favoritos": coloresFavoritos,
    if (lugaresFavoritos.isNotEmpty)
      "lugares favoritos": lugaresFavoritos
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
        ? List.from(
            datos["lugaresFavoritos"]
                .map((datosLugar) => Ubicacion.fromJson(datosLugar))
                .toList(),
          )
        : null,
  );
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
          "colores favoritos: ${coloresFavoritos.join(", ")}",
        if (lugaresFavoritos.isNotEmpty)
          "lugares favoritos: ${lugaresFavoritos.join(", ")}",
      ].map((e) => "\t$e").join("\n"),
      ")",
    ].join("\n");
  }
}
