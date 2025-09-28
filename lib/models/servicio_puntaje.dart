// lib/models/servicio_puntaje.dart

import 'package:shared_preferences/shared_preferences.dart'; 

class ServicioPuntaje {
  static const String _keyWon = 'gamesGanadas';
  static const String _keyLost = 'gamesPerdidas';
  
  // 1. Carga las puntuaciones guardadas.
  Future<Map<String, int>> cargarPuntuaciones() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'ganadas': prefs.getInt(_keyWon) ?? 0,
      'perdidas': prefs.getInt(_keyLost) ?? 0,
    };
  }

  // 2. Guarda las puntuaciones.
  Future<void> guardarPuntuaciones(int ganadas, int perdidas) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyWon, ganadas);
    await prefs.setInt(_keyLost, perdidas);
  }
}