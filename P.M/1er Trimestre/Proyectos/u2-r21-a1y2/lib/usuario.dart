import 'package:age_calculator/age_calculator.dart';
import 'package:u2_r21_a1y2/base.dart';

class Usuario extends Base {
  int id;
  String username;
  String password;
  String email;
  String? nombre;
  String? apellidos;
  String? nacionalidad;
  DateTime? nacimiento;
  final DateTime creacion;
  Usuario({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    this.nombre = "Desconocido",
    this.apellidos = "Desconocido",
    this.nacionalidad = "España",
    String? nacimientoString,
    super.context, //Abreviado con la lupa (ayuda del entorno)
  }) : creacion = DateTime.now() {
    nacimiento = (nacimientoString != null)
        ? DateTime.tryParse(nacimientoString)
        : null;
  }
  Usuario copyWith({
    int? id,
    String? username,
    String? password,
    String? email,
    String? nombre,
    String? apellidos,
    String? nacionalidad,
    String? nacimientoString,
  }) {
    return Usuario(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      nacionalidad: nacionalidad ?? this.nacionalidad,
      nacimientoString: nacimientoString ?? this.nacimiento?.toString(),
    );
  }

  Usuario.anonimo()
    : id = 0,
      username = "",
      password = "",
      email = "",
      creacion = DateTime.now();
  factory Usuario.fromString(String datos) {
    List<String> datosLista = datos.split(',');
    int idAUX = int.tryParse(datosLista[0]) ?? 0;
    return Usuario(
      id: idAUX,
      username: datosLista[1],
      password: datosLista[2],
      email: datosLista[3],
      nombre: datosLista[4],
      apellidos: datosLista[5],
      nacionalidad: datosLista[6],
      nacimientoString: datosLista.length > 7 ? datosLista[7] : null,
    );
  }
  int? get edad => (nacimiento == null) ? null : AgeCalculator.age(nacimiento!, today: DateTime.now()).years;
  
  String get nombreCompleto => "$nombre $apellidos";
  @override
  String toString() {
    return """Usuario(
                Id: $id
                Username: $username
                Password: $password
                Email: $email
                Nombre: $nombre
                Apellidos: $apellidos
                Nacionalidad: $nacionalidad
                Nacimiento: $nacimiento
                Edad: $edad
              )""";
  }
}
