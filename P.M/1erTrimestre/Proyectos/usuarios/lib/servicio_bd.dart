class ServicioBD {
  static ServicioBD? _instancia;

  ServicioBD._();

  factory ServicioBD() => _instancia = _instancia ?? ServicioBD._();
}
