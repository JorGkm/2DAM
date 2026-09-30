
class UsuarioNoMutable {
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
  const UsuarioNoMutable._(
    this.id,
    this.username,
    this.password,
    this.email, {
    this.nombre = "Desconocido",
    this.apellidos = "Desconocido",
    this.nacionalidad = "España",
    this.nacimiento
  });

  factory UsuarioNoMutable(
  int id,
  String username,
  String password,
  String email, {
  String? nombre = "Desconocido",
  String? apellidos = "Desconocido",
  String? nacionalidad = "España",
  String? nacimientoString,
}) {
  return UsuarioNoMutable._(
    id, username, password, email,
    nombre: nombre,
    apellidos: apellidos,
    nacionalidad: nacionalidad,
    nacimiento: (nacimientoString != null)
        ? DateTime.tryParse(nacimientoString)
        : null,
  );
}

  //Es una buena práctica tener un metodo como este debido a que se puede "modificar" el objeto inmutable,
  //creas un nuevo objeto con todos los datos del otro en caso de que no tengan datos nuevos pasados por parámetros
  
  UsuarioNoMutable copyWith({
    int? id,
    String? username,
    String? password,
    String? email,
    String? nombre,
    String? apellidos,
    String? nacionalidad,
    DateTime? nacimiento
  }){
    return UsuarioNoMutable._(
      id ?? this.id,
      username ?? this.username,
      password ?? this.password,
      email ?? this.email,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      nacionalidad: nacionalidad ?? this.nacionalidad,
      nacimiento: nacimiento ?? this.nacimiento
    );
  } 
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
              )""";
  }
}
