import 'dart:io';
import 'dart:math';

void adivinaElNumero({int max = 101}) {
  print("[ADIVINA EL NÚMERO]");
  Random nRnd = Random();
  int intento = 1;
  bool exito = false;
  final numObjetivo = nRnd.nextInt(max);
  do {
    stdout.write("Intento $intento: ");
    String? input = stdin.readLineSync();
    if (input != null && input != "") {
      int numero = int.parse(input);
      if(numero == numObjetivo){
        print("!ÉXITO¡ has adivinado el número en $intento intentos");
        exito = true;
      }else{
        if(numero < numObjetivo)
        print("¡Ay! Casi..., el número es más grande");
        else
        print("Madre, te has pasado");
      }
    } else {
      print("ERROR: Porfavor introduzca un número");
    }
    intento++;
  } while (!exito);
}
