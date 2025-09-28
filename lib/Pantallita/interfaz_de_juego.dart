import 'package:a/Logica/ahorcado.dart';
import 'package:flutter/material.dart';


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
            gano ? '¡Felicidades, adivinaste la palabra!' : 'La palabra era: ${juego.palabraCompleta}'),
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
            letrasAhorcado(),
            Text(
              'Intentos Restantes: ${juego.intentosRestantes}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            // 2. Palabra a Adivinar
            Text(
              juego.palabraMostrada,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 10),
            ),

            // Separador visual
            const Divider(),

            // 3. Teclado Interactivo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Evita scroll innecesario
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, // 7 letras por fila (adecuado para un teclado QWERTY visual)
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
           /// if (juego.haGanado || juego.haPerdido)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: _reiniciarJuego,
           //       child: const Text('REINICIAR JUEGO', style: TextStyle(fontSize: 15)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}