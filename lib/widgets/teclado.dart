// lib/componentes/teclado.dart

import 'package:flutter/material.dart';

class Teclado extends StatelessWidget {
  final List<String> letrasIntentadas;
  final Function(String) alPresionarLetra;
  final bool juegoTerminado;
  final String palabraCompleta; 

  const Teclado({
    super.key,
    required this.letrasIntentadas,
    required this.alPresionarLetra,
    required this.juegoTerminado,
    required this.palabraCompleta,
  });

  // Define las teclas en filas para usar Rows
  final List<List<String>> _filasTeclado = const [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Ñ'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  @override
  Widget build(BuildContext context) {
    // 1. Column principal: Apila las filas de botones verticalmente
    return Column(
      children: _filasTeclado.map((filaLetras) {
        // 2. Row: Distribuye los botones de cada fila horizontalmente
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: filaLetras.map((letra) {
              bool fueIntentada = letrasIntentadas.contains(letra);
              bool esCorrecta = palabraCompleta.contains(letra);
              
              Color colorBoton = Colors.blue.shade700;

              if (fueIntentada) {
                // Color si la letra fue intentada
                colorBoton = esCorrecta ? Colors.green.shade600 : Colors.red.shade600;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                child: SizedBox(
                  width: 32,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (fueIntentada || juegoTerminado)
                        ? null // Deshabilita si ya se usó o si el juego terminó
                        : () => alPresionarLetra(letra),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorBoton,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    child: Text(
                      letra,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}