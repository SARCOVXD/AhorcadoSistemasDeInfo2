// lib/componentes/puntaje.dart

import 'package:flutter/material.dart';

class Puntaje extends StatelessWidget {
  final int jugadas;
  final int ganadas;
  final int perdidas;
  final int intentosRestantes;

  const Puntaje({
    super.key,
    required this.jugadas,
    required this.ganadas,
    required this.perdidas,
    required this.intentosRestantes,
  });

  // Widget auxiliar que usa Column para apilar Título y Valor
  Widget _construirEstadistica(String titulo, String valor, [Color color = Colors.black]) {
    // Definimos el color azul como la opción por defecto para los valores
    Color colorValor = color == Colors.black ? Colors.blue.shade700 : color; 
    
    // Column: apila el título sobre el valor
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(titulo, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        Text(valor, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorValor)), // Usamos colorValor aquí
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Row principal: Distribuye todas las estadísticas horizontalmente.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Intentos Restantes: Ya usa azul (o rojo si quedan pocos)
          _construirEstadistica('Intentos', intentosRestantes.toString(), 
                                intentosRestantes > 2 ? Colors.blue.shade700 : Colors.red),
          
          // Ganadas: Mantiene el verde (Color que indica estado)
          _construirEstadistica('Ganadas', ganadas.toString(), Colors.green.shade700),
          
          // Perdidas: Mantiene el rojo (Color que indica estado)
          _construirEstadistica('Perdidas', perdidas.toString(), Colors.red.shade700),
          
          // Total Jugadas: Ahora usará el azul por defecto
          _construirEstadistica('Total', jugadas.toString()),
        ],
      ),
    );
  }
}