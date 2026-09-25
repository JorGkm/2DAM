import 'dart:io';

import 'package:hola_mundo/hola_mundo.dart' as hola_mundo;

void main(List<String> arguments) {
  print('Hello world: ${hola_mundo.calculate()}!');
  //Código ya hecho por mi por primera vez
  String nombreAlumno = "Jorge";
  //Forma simple de conseguir la edad aproximada del alumno ya que requiere más comprobaciones de mes y día para ser exactos
  DateTime fechaNacimiento = DateTime(2005,09,05);
  int edadAlumno = DateTime.now().year - fechaNacimiento.year;
  //Mostramos por consola la cadena siguiente con la interpolación del contenido de las variables anteriores
  print("Hola $nombreAlumno, naciste el $fechaNacimiento por lo que este año cumples $edadAlumno");
  print("¿Como te encuentras hoy?");
  stdout.write("Cómo te sientes: ");
  String bienestar = stdin.readLineSync() ?? "...";
  print(bienestar);
  hola_mundo.metodoEjemplo();
  //Tratamos de crear el primer objeto y realizar uno de sus métodos estáticos (arreglarlo)
  var PrimerObj = hola_mundo.PrimeraClase();
  print(PrimerObj.numero1);
  hola_mundo.PrimeraClase.sumar(4,4);

}
