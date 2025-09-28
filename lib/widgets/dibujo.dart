// lib/componentes/dibujo.dart

import 'package:flutter/material.dart';

class Dibujo extends StatelessWidget {
  final int intentosIncorrectos;
  static const Color colorMadera = Color(0xFF8B4513); // Color marrón para la horca
  static const Color colorMuneco = Colors.red; // Color rojo para el muñeco

  const Dibujo({super.key, required this.intentosIncorrectos});

  // Un widget auxiliar para dibujar la horca y el muñeco
  Widget _dibujarParte(bool esVisible, Widget parte) {
    return Visibility(
      visible: esVisible,
      maintainSize: true, 
      maintainAnimation: true,
      maintainState: true,
      child: parte,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 180, 
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Estructura de la horca: (Poste Vertical y Techo)
              Positioned(top: 0, left: 100, child: Container(width: 50, height: 5, color: colorMadera)),
              Positioned(top: 0, left: 100, child: Container(width: 5, height: 180, color: colorMadera)),
              
              // 1. Cuerda (Fallo 1, puede ser parte de la horca)
              _dibujarParte(intentosIncorrectos >= 1, 
                Positioned(top: 0, left: 50, child: Container(width: 3, height: 20, color: colorMadera))
              ),

              // 2. Cabeza (Fallo 2)
              _dibujarParte(intentosIncorrectos >= 2,
                Positioned(top: 20, left: 40, child: CircleAvatar(radius: 12, backgroundColor: colorMuneco)) // CAMBIADO A colorMuneco
              ),

              // 3. Cuerpo (Fallo 3)
              _dibujarParte(intentosIncorrectos >= 3,
                Positioned(top: 45, left: 50, child: Container(width: 3, height: 40, color: colorMuneco)) // CAMBIADO A colorMuneco
              ),
              
              // 4. Brazo Izquierdo (Fallo 4)
              _dibujarParte(intentosIncorrectos >= 4,
                Positioned(top: 45, left: 35, child: Transform.rotate(angle: 0.5, child: Container(width: 3, height: 25, color: colorMuneco))) // CAMBIADO A colorMuneco
              ),
              
              // 5. Brazo Derecho (Fallo 5)
              _dibujarParte(intentosIncorrectos >= 5,
                Positioned(top: 45, left: 65, child: Transform.rotate(angle: -0.5, child: Container(width: 3, height: 25, color: colorMuneco))) // CAMBIADO A colorMuneco
              ),

              // 6. Pierna Izquierda (Fallo 6)
              _dibujarParte(intentosIncorrectos >= 6,
                Positioned(top: 85, left: 35, child: Transform.rotate(angle: 0.8, child: Container(width: 3, height: 30, color: colorMuneco))) // CAMBIADO A colorMuneco
              ),
              
              // 7. Pierna Derecha (Fallo 7)
              _dibujarParte(intentosIncorrectos >= 7,
                Positioned(top: 85, left: 65, child: Transform.rotate(angle: -0.8, child: Container(width: 3, height: 30, color: colorMuneco))) // CAMBIADO A colorMuneco
              ),
            ],
          ),
        ),
        // La base de la horca
        Container(width: 200, height: 10, color: colorMadera),
      ],
    );
  }
}