import 'package:ejemplosdart/ejemplosdart.dart';
import 'package:ejemplosdart/ubicacion.class.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });

  test('Ubicacion convierte la fecha JSON a DateTime y viceversa', () {
    final ubicacion = Ubicacion.fromJson({
      'nombre': 'Málaga',
      'fechaUltimaVisita': '2025-08-12',
    });

    expect(ubicacion.fechaUltimaVisita, DateTime(2025, 8, 12));
    expect(ubicacion.toJson(), {
      'nombre': 'Málaga',
      'fechaUltimaVisita': '2025-08-12',
    });
  });
}
