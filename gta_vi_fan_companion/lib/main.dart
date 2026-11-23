import 'package:control_luna/control_luna.dart';
import 'package:flutter/material.dart';
import 'package:gta_selector_card/gta_selector_card.dart';
import 'package:protagonistas_gta/protagonistas_gta.dart';

const _edicionesGta = ['I', 'II', 'III', 'IV', 'V', 'VI'];
const _protagonistas = <Protagonista>[
  Protagonista(
    id: 'lucia',
    nombre: 'Lucía',
    rol: 'Protagonista',
    icono: Icons.account_box,
    colorPersonaje: Color(0xFFFF2D87),
  ),
  Protagonista(
    id: 'jason',
    nombre: 'Jason',
    rol: 'Protagonista',
    icono: Icons.shield,
    iconoInterior: Icons.person,
    colorPersonaje: Color(0xFF00F0FF),
    etiquetaActiva: 'ACTIVO',
  ),
];

void main() => runApp(const GtaFanCompanionApp());

class GtaFanCompanionApp extends StatelessWidget {
  const GtaFanCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTA VI - Vice City',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF070A12),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00F0FF),
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFF00F0FF),
          secondary: const Color(0xFFFF2D87),
          surface: const Color(0xFF10162A),
        ),
      ),
      home: const PantallaGta(),
    );
  }
}

class PantallaGta extends StatefulWidget {
  const PantallaGta({super.key});

  @override
  State<PantallaGta> createState() => _PantallaGtaState();
}

class _PantallaGtaState extends State<PantallaGta> {
  var _faseLuna = 5;
  var _personajeActivo = 'lucia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ControlLuna(
                    valor: _faseLuna,
                    onChanged: (valor) => setState(() => _faseLuna = valor),
                  ),
                  const SizedBox(height: 18),
                  SelectorProtagonistas(
                    protagonistas: _protagonistas,
                    idActivo: _personajeActivo,
                    onSeleccionado: (personaje) =>
                        setState(() => _personajeActivo = personaje.id),
                  ),
                  const SizedBox(height: 18),
                  GtaSelectorCard(
                    initialIndex: 5,
                    options: _edicionesGta,
                    onChanged: _alElegirGta,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _alElegirGta(int indice) {
    final gtaElegido = _edicionesGta[indice];
    final mensajero = ScaffoldMessenger.of(context);
    mensajero
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Favorito actualizado: GTA $gtaElegido'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
