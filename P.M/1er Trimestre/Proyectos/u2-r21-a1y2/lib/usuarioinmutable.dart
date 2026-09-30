import 'dart:ffi';

class UsuarioInmutable {
  final int id;
  final String username;
  final String password;
  final String email;
  final String? nombre;
  final String? apellidos;
  final String? nacionalidad;
  final DateTime? nacimiento;
  //Para que el constructor sea constante, debemos poner todos los atributos como final, serán constantes pero
  //el valor se adjudicará en runtime
   UsuarioInmutable._(
    this.id,
    this.username,
    this.password,
    this.email, {
    this.nombre = "Desconocido",
    this.apellidos = "Desconocido",
    this.nacionalidad = "España",
    this.nacimiento
  });

  //Es una buena práctica tener un metodo como este debido a que se puede "modificar" el objeto inmutable,
  //creas un nuevo objeto con todos los datos del otro en caso de que no tengan datos nuevos pasados por parámetros
  
  UsuarioInmutable copyWith({
    int? id,
    String? username,
    String? password,
    String? email,
    String? nombre,
    String? apellidos,
    String? nacionalidad,
  }){
    return UsuarioInmutable._(
      id ?? this.id,
      username ?? this.username,
      password ?? this.password,
      email ?? this.email,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      nacionalidad: nacionalidad ?? this.nacionalidad,
    );
  }
 UsuarioInmutable 
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
              )""";
  }
}
