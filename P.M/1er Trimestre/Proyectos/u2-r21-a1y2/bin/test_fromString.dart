import '../lib/usuario.dart';

void main() {
  var u = Usuario.fromString('42,juanito,secreto,juanito@email.com,Juan,Pérez,España,1995-05-15');
  print(u);
  print('---');
  print('id: ${u.id}');
  print('username: ${u.username}');
  print('email: ${u.email}');
  print('nombre: ${u.nombre}');
  print('apellidos: ${u.apellidos}');
  print('nacionalidad: ${u.nacionalidad}');
  print('nacimiento: ${u.nacimiento}');
  print('creacion: ${u.creacion}');
}
