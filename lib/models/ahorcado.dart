class Ahorcado {
  // Lista de palabras posibles
  final List<String> _listaPalabras = [
    'FLUTTER',
    'DART',
    'WIDGET',
    'MOBILE',
    'APLICACION',
    'GUATIRE',
    'CODIGO',
  ];

  late String _palabraAdivinar;
  final List<String> _letrasIntentadas = [];
  int _intentosIncorrectos = 0;
  static const int _maxIntentosIncorrectos = 7;

  // --- MÉTODOS PÚBLICOS ---

  // Inicia una nueva partida
  void iniciarJuego() {

    _palabraAdivinar = _listaPalabras[
    DateTime.now().microsecondsSinceEpoch % _listaPalabras.length];
    _letrasIntentadas.clear();
    _intentosIncorrectos = 0;
  }

  // Intenta adivinar una letra
  bool intentarLetra(String letra) {
    String letraMayuscula = letra.toUpperCase();


    if (_letrasIntentadas.contains(letraMayuscula)) {
      return true;
    }


    _letrasIntentadas.add(letraMayuscula);


    if (_palabraAdivinar.contains(letraMayuscula)) {
      return true;
    } else {
      _intentosIncorrectos++;
      return false;
    }
  }



  // Muestra la palabra con guiones bajos o letras adivinadas
  String get palabraMostrada {
    String mostrado = '';
    for (int i = 0; i < _palabraAdivinar.length; i++) {
      String caracter = _palabraAdivinar[i];
      if (_letrasIntentadas.contains(caracter)) {
        mostrado += caracter;
      } else {
        mostrado += '_';
      }
      mostrado += ' '; // Añadir espacio para mejor legibilidad
    }
    return mostrado.trim();
  }

  // Devuelve la palabra completa a adivinar (útil para cuando se pierde)
  String get palabraCompleta => _palabraAdivinar;

  // Indica si el jugador ha ganado
  bool get haGanado {
    return !palabraMostrada.contains('_');
  }

  // Indica si el jugador ha perdido
  bool get haPerdido {
    return _intentosIncorrectos >= _maxIntentosIncorrectos;
  }

  // Número de errores cometidos
  int get intentosIncorrectos => _intentosIncorrectos;

  // Intentos restantes
  int get intentosRestantes => _maxIntentosIncorrectos - _intentosIncorrectos;

  // Letras que ya han sido intentadas
  List<String> get letrasIntentadas => List.unmodifiable(_letrasIntentadas);
}

//DIBUJO :)

