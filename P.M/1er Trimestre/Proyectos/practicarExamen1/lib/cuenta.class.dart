class Cuenta {
  int id;
  String username;
  String email;
  bool premium;
  double puntos;
  DateTime nacimiento;
  List<String> aficiones;

  Cuenta({
    required this.id,
    required this.username,
    required this.email,
    required this.premium,
    required this.puntos,
    required this.nacimiento,
    required this.aficiones,
  });
  @override
  String toString() =>
      "Cuenta(id: $id, username: $username, email: $email, premium: $premium, puntos: $puntos, nacimiento: ${nacimiento.toIso8601String().split('T')[0]}, aficiones: $aficiones)";
  int get edad => DateTime.now().year - nacimiento.year;
  Map<String, Object> Function() copyWith() => 
  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "premium": premium,
    "puntos": puntos,
    "nacimiento": nacimiento,
    "aficiones": aficiones,
  };
  factory Cuenta.fromJson(Map<String, dynamic> datos) => Cuenta(
    id: datos["id"],
    username: datos["username"],
    email: datos["email"],
    premium: datos["premium"],
    puntos: datos["puntos"],
    nacimiento: datos["nacimiento"],
    aficiones: datos["aficiones"],
  );
}
