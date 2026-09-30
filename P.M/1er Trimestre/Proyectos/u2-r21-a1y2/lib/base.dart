abstract class Base {
  //Contador compartido por todas las instancias de Base y de sus subclases
  static int _numInstancias = 0;

  //Por defecto es null al no darle valor inicial
  Base? context;

  Base({this.context}) {
    //Se incrementa en el cuerpo (no en la lista de inicializadores) para que
    //cuente también las instancias creadas por las subclases que llaman a super()
    _numInstancias++;
  }
  static int get numInstancias => _numInstancias;
}
