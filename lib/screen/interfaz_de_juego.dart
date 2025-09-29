import 'package:a/models/ahorcado.dart';
import 'package:flutter/material.dart';
class DibujoAhorcado extends CustomPainter {
  final int intentosIncorrectos; // El número de errores que el juego pasa a este dibujante

  DibujoAhorcado(this.intentosIncorrectos);

  @override
  void paint(Canvas canvas, Size size) {
    // Definimos el "lápiz" o "pincel" para dibujar
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    // --- Definición de Puntos Clave ---
    // Usamos el ancho (size.width) y alto (size.height) para posicionar todo

    // Base (Horizontal inferior)
    canvas.drawLine(Offset(size.width * 0.1, size.height * 0.9), Offset(size.width * 0.9, size.height * 0.9), paint);

    // Poste vertical
    if (intentosIncorrectos >= 1) {
      canvas.drawLine(Offset(size.width * 0.2, size.height * 0.9), Offset(size.width * 0.2, size.height * 0.1), paint);
    }

    // Viga horizontal superior
    if (intentosIncorrectos >= 2) {
      canvas.drawLine(Offset(size.width * 0.2, size.height * 0.1), Offset(size.width * 0.7, size.height * 0.1), paint);
    }

    // Cuerda/soporte
    if (intentosIncorrectos >= 3) {
      canvas.drawLine(Offset(size.width * 0.7, size.height * 0.1), Offset(size.width * 0.7, size.height * 0.2), paint);
    }

    // --- Dibujo del Muñeco (Empieza desde el 4to error) ---

    // 4. Cabeza
    if (intentosIncorrectos >= 4) {
      canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.25), 25, paint..style = PaintingStyle.stroke);
    }

    // 5. Cuerpo
    if (intentosIncorrectos >= 5) {
      canvas.drawLine(Offset(size.width * 0.7, size.height * 0.35), Offset(size.width * 0.7, size.height * 0.65), paint);
    }

    // 6. Brazo Izquierdo
    if (intentosIncorrectos >= 6) {
      canvas.drawLine(Offset(size.width * 0.7, size.height * 0.4), Offset(size.width * 0.6, size.height * 0.55), paint);
    }

    // 7. Brazo Derecho
    if (intentosIncorrectos >= 7) {
      canvas.drawLine(Offset(size.width * 0.7, size.height * 0.4), Offset(size.width * 0.8, size.height * 0.55), paint);
    }

    // 8. Piernas (Dos líneas, esto significa que necesitamos más de 7 intentos,
    // pero como solo tienes 7 intentos máximos, haremos que las dos piernas aparezcan
    // en el último intento para mantener la proporción de 7 errores/8 partes).
    if (intentosIncorrectos >= 7) {
      canvas.drawLine(Offset(size.width * 0.7, size.height * 0.65), Offset(size.width * 0.6, size.height * 0.8), paint);
      canvas.drawLine(Offset(size.width * 0.7, size.height * 0.65), Offset(size.width * 0.8, size.height * 0.8), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Repintar solo si el número de errores ha cambiado
    return true;
  }
}

class PantallaAhorcado extends StatefulWidget {
  const PantallaAhorcado({super.key});

  @override
  State<PantallaAhorcado> createState() => _EstadoPantallaAhorcado();
}

class _EstadoPantallaAhorcado extends State<PantallaAhorcado> {
  final Ahorcado juego = Ahorcado();

  @override
  void initState() {
    super.initState();
    juego.iniciarJuego(); // Inicia el juego al cargar la pantalla
  }


  // Manejador del evento de pulsar una letra
  void _manejarIntento(String letra) {
    // Si el juego ha terminado, no hacer nada
    if (juego.haGanado || juego.haPerdido) return;


    if (!juego.letrasIntentadas.contains(letra.toUpperCase())) {
      bool esAcierto = juego.intentarLetra(letra);


      setState(() {

      });

      // Muestra un diálogo si el juego ha terminado después del intento
      if (juego.haGanado) {
        _mostrarDialogoResultado(true);
      } else if (juego.haPerdido) {
        _mostrarDialogoResultado(false);
      }
    }
  }

  // Reinicia el juego
  void _reiniciarJuego() {
    setState(() {
      juego.iniciarJuego();
    });
  }

  // Muestra un diálogo de ganar o perder
  void _mostrarDialogoResultado(bool gano) {
    showDialog(
      context: context,
      barrierDismissible: false, // El usuario debe pulsar un botón para salir
      builder: (context) => AlertDialog(
        title: Text(gano ? 'Que crack eres sigue asi' : 'Mejora tu vocabulario mi pana 😔'),
        content: Text(
            gano ? '¡Felicidades, VAMOSS!' : 'La palabra era: ${juego.palabraCompleta}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _reiniciarJuego();
            },
            child: const Text('Jugar de Nuevo'),
          ),
        ],
      ),
    );
  }

  // PALABRAS DEL AHORCADO
  Widget letrasAhorcado() {

    return Text(
      'Etapa: ${juego.intentosIncorrectos} de 7',
      style: TextStyle(fontSize: 18, color: juego.haPerdido ? Colors.red : Colors.black),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('El Ahorcado MICROPROYECTO 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // 1. Contador de Intentos y Dibujo
            dibujarAhorcado(),
            Text(
              'Intentos Restantes: ${juego.intentosRestantes}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            // 2. Palabra a Adivinar
            Text(
              juego.palabraMostrada,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 10),
            ),



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Evita scroll innecesario
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 13,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: 1.0,
                ),
                itemCount: 26, // 26 letras del abecedario
                itemBuilder: (context, index) {
                  // Genera las letras de 'A' a 'Z'
                  String letra = String.fromCharCode('A'.codeUnitAt(0) + index);
                  bool fueIntentada = juego.letrasIntentadas.contains(letra);
                  bool esCorrecta = juego.palabraCompleta.contains(letra);
                  bool juegoTerminado = juego.haGanado || juego.haPerdido;

                  Color colorBoton = Colors.green;
                  if (fueIntentada) {
                    colorBoton = esCorrecta ? Colors.green.shade700 : Colors.red.shade700;
                  }

                  return ElevatedButton(
                    onPressed: (fueIntentada || juegoTerminado) ? null : () => _manejarIntento(letra),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorBoton,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                        letra,
                        style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
                    ),
                  );
                },
              ),
            ),

            // Botón de Reiniciar
            if (juego.haGanado || juego.haPerdido)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: _reiniciarJuego,
                child: const Text('REINICIAR JUEGO', style: TextStyle(fontSize: 15)),
                ),
              ),

          ],
        ),
      ),
    );

  }
  Widget dibujarAhorcado() {
    return Container(
      // Damos un tamaño fijo al área de dibujo
      width: 250,
      height: 250,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300) // Un borde suave para definir el área
      ),

      // Usamos el widget CustomPaint y le pasamos nuestra clase dibujadora
      child: CustomPaint(
        painter: DibujoAhorcado(juego.intentosIncorrectos),
      ),
    );
  }
}