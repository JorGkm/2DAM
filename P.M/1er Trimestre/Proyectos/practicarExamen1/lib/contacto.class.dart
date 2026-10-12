class Contacto {
  String telefono;
  String? web;
  Contacto({required this.telefono, this.web});
  @override
  String toString() => "Contacto(telefono: $telefono, web: $web)";

  Contacto copyWith({String? telefono, String? web}) =>
      Contacto(telefono: telefono ?? this.telefono, web: web ?? this.web);
  Map<String, dynamic> toJson() =>{
    "telefono" : telefono,
    "web" : web
  };
  factory Contacto.fromJson(Map<String, dynamic> datos) => Contacto(telefono: datos["telefono"], web: datos["web"]);
}
