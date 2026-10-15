class Persona {
  String nombre;
  int edad;

  // Constructor por defecto
  Persona(this.nombre, this.edad); // Constructor por defecto

  // Constructor con nombre
  Persona.nacimiento(this.nombre) : edad = 0;

  // Constructor factory
  factory Persona.adulto(String nombre, [int edad = 18]) {
    return Persona(nombre, edad);
  }

  String saludar() {
    return 'Hola, soy $nombre y tengo $edad años.';
  }
}
