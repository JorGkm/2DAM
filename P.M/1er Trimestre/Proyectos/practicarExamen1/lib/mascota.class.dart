class Mascota {
  String nombre;
  String especie;
  final List<String> vacunas;

  Mascota({required this.nombre, required this.especie, List<String>? vacunas})
    : vacunas = vacunas ?? [];
  @override
  String toString() =>
      "Mascota(nombre: $nombre, especie: $especie, vacunas: $vacunas)";
  Mascota copyWith({String? nombre, String? especie, List<String>? vacunas}) =>
      Mascota(
        nombre: nombre ?? this.nombre,
        especie: especie ?? this.especie,
        vacunas: List.from(vacunas ?? this.vacunas),
      );
  int get numVacunas => vacunas.length;
  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "especie": especie,
    "vacunas": vacunas,
  };
  factory Mascota.fromJson(Map<String, dynamic> datos) => Mascota(
    nombre: datos["nombre"],
    especie: datos["especie"],
    vacunas: datos["vacunas"],
  );
}
