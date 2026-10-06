class Ubicacion {
  String nombre;
  DateTime fechaUltimaVisita;

  Ubicacion({required this.nombre, required this.fechaUltimaVisita});

  @override
  String toString() {
    return [
      "Ubicacion(",
      [
        "Nombre: $nombre",
        "Fecha última visita: ${fechaUltimaVisita.toIso8601String()}",
      ].map((e) => "  $e").join("\n"),
      ")",
    ].join("\n");
  }

  Ubicacion copyWith({String? nombre, DateTime? fechaUltimaVisita}) =>
      Ubicacion(
        nombre: nombre ?? this.nombre,
        fechaUltimaVisita: fechaUltimaVisita ?? this.fechaUltimaVisita,
      );

  factory Ubicacion.fromJson(Map<String, dynamic> json) => Ubicacion(
        nombre: json["nombre"] as String,
        fechaUltimaVisita: DateTime.parse(json["fechaUltimaVisita"] as String),
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "fechaUltimaVisita": fechaUltimaVisita.toIso8601String().split("T").first,
      };
}