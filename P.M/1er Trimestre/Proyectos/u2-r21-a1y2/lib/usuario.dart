import 'package:age_calculator/age_calculator.dart';

class Usuario {
  int id;
  String username;
  String password;
  String email;
  String? nombre;
  String? apellidos;
  String? nacionalidad;
  DateTime? nacimiento;
  final creacion;
  Usuario(
    this.id,
    this.username,
    this.password,
    this.email, {
    String? nombre = "Desconocido",
    String? apellidos = "Desconocido",
    String? nacionalidad = "España",
    String? nacimientoString
  }): creacion = DateTime.now(){
    nacimiento = (nacimientoString != null) ? DateTime.tryParse(nacimientoString) : null;
  }
  Usuario copyWith({
    int? id,
    String? username,
    String? password,
    String? email,
    String? nombre,
    String? apellidos,
    String? nacionalidad,
  }) {
    return Usuario(
      id ?? this.id,
      username ?? this.username,
      password ?? this.password,
      email ?? this.email,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      nacionalidad: nacionalidad ?? this.nacionalidad,
    );
  }
  Usuario.anonimo(): id = 0, username = "", password = "", email = "", creacion = DateTime.now();
  factory Usuario.fromString(String datos){
    List<String> datosLista = datos.split(',');
    int idAUX = int.tryParse(datosLista[0]) ?? 0;
    return Usuario(idAUX,datosLista[1],datosLista[2],datosLista[3], nombre: datosLista[4],apellidos: datosLista[5],nacionalidad: datosLista[6],nacimientoString: datosLista[7]);
  } 
  int edad(){
    if(nacimiento != null){
      DateDuration intervalo = AgeCalculator.age(nacimiento!, today: DateTime(2026,9,29)); 
      //AVISO tiene la '!' debido a su control de null pero no significa que no vaya a tenerlo ahí ya que es posible
      return intervalo.years;
    }
    return 0;
  } 
  String nombreCompleto() => "$apellidos, $nombre";
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
                Nacimineto: $nacimiento
                Edad: $edad()
              )""";
  }
}
