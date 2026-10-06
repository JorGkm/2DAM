import 'package:practicar_clase/practicar_clase.dart';
import 'package:practicar_clase/usuario.class.dart';



void main(List<String> arguments) {
  final List<Usuario> usuarios = cargarUsuarios('bin/persona.json');

  print("Total de usuarios: ${usuarios.length}\n");
  for (final Usuario usuario in usuarios) {
    print(usuario);
  }
}
