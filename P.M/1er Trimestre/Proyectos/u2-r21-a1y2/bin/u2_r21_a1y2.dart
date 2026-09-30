
import 'package:u2_r21_a1y2/base.dart';
import 'package:u2_r21_a1y2/usuario.dart';
import 'package:u2_r21_a1y2/usuarionoMutable.class.dart';
void main(List<String> arguments) {
  //adivinaElNumero(max: 68);
  Usuario user = Usuario(id: 1, username: "JorG",
      password: "joseesperoaprobar2026", email: "rasuba@gmail.com");
  print(user);
   UsuarioNoMutable user2 = UsuarioNoMutable(1, "Dart", "fluttereslomejor",
      "pajaritoasul@gmail.com",
      nombre: "Piolin",
      apellidos: "Millán",
      nacimientoString: "2005-06-13");
  print(user2);

  final copia = user2.copyWith(nacimiento: DateTime(2000, 1, 1));
  print(copia.nacimiento);

  final sinFecha = UsuarioNoMutable(2, "otro", "pass", "otro@mail.com",
      nacimientoString: "no-es-una-fecha");
  print(sinFecha.nacimiento);

  //  Prueba de Base.numInstancias 
  print("inicio: ${Base.numInstancias} (solo los 2 Usuario de arriba, "
      "UsuarioNoMutable NO hereda de Base)");
  final u3 = Usuario(id: 3, username: "a", password: "p", email: "a@a.com");
  print("tras 1 Usuario mas: ${Base.numInstancias}");
  final u4 = Usuario(id: 4, username: "b", password: "p", email: "b@b.com",
      context: u3);
  print("tras otro Usuario (usando a u3 como context): ${Base.numInstancias} "
      "u4.context=${u4.context}");
  Usuario.anonimo();
  Usuario.fromString('42,j,s,p,j@e.com,J,P,E,1995-05-15');
  print("tras Usuario.anonimo() y Usuario.fromString(): ${Base.numInstancias}");

  //Ejercicio 7: Usuario.anonimo() 
  final anonimo = Usuario.anonimo();
  print(anonimo);
  print("nombreCompleto del anonimo: '${anonimo.nombreCompleto}' "
      "(vacio = null) | edad=${anonimo.edad}");

  //Ejercicio 8: Usuario.fromString() 
  final desdeTexto = Usuario.fromString(
      '7,mgomez,clave7,mgomez@iesportada.org,María,Gómez,Ecuador,1975-10-21');
  print(desdeTexto);
  print("nombreCompleto: ${desdeTexto.nombreCompleto} | edad=${desdeTexto.edad}");
  // sin el campo 8 (nacimiento) no debe romperse
  print("sin fecha -> ${Usuario.fromString('8,s,s,s,s,s,España').nacimiento}");

  //Ejercicio 2: UsuarioNomutable NO es mutable 
  // No se puede escribir, las propiedades son "final". Si descomentas la
  // linea de abajo el analizador da error:
  //   final Nombre: no se puede asignar a un "final" 
  //   user2.nombre = "otro";     //ERROR de compilacion
  print("--- Comprobacion de inmutabilidad ---");
  final modificado = user2.copyWith(nombre: "Tweety");
  print("original sin tocar : ${user2.nombreCompleto} (id ${user2.id})");
  print("la copia tiene     : ${modificado.nombreCompleto} (id ${modificado.id})");
  print("son el mismo objeto? ${identical(user2, modificado)}  <-- false = inmutable");
  print("equal() coincide?   ${user2 == modificado}  <-- false, cada uno es un objeto");
}
