import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/rendering.dart';

const _fondo = Color(0xFF141D38);
const _fondoSlider = Color(0xFF202A43);
const _borde = Color(0xFF232B47);
const _luna = Color(0xFFFFF8E7);
const _cian = Color(0xFF00F0FF);
const _rosa = Color(0xFFFF2D87);
const _textoSuave = Color(0xFFB0B7C9);

class ControlLuna extends StatelessWidget {
  const ControlLuna({
    super.key,
    required this.valor,
    required this.onChanged,
    this.valorMaximo = 6,
    this.titulo = 'MOVER LUNA',
  }) : assert(valorMaximo > 1),
       assert(valor >= 1 && valor <= valorMaximo);

  final int valor;
  final int valorMaximo;
  final String titulo;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: titulo,
      value: '$valor / $valorMaximo',
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 17, 18, 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF16213E), Color(0xFF10182E)],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _borde),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'GTA ',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: 'VI',
                              style: TextStyle(color: _rosa),
                            ),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 25,
                          height: 1,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.7,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'VICE CITY',
                        style: TextStyle(
                          color: _cian,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _rosa.withAlpha(150)),
                    color: const Color(0xFF0B1226),
                  ),
                  child: CustomPaint(
                    painter: _PintorLuna(fase: valor, totalFases: valorMaximo),
                  ),
                ),
              ],
            ),
            const Divider(height: 20, color: _borde),
            Row(
              children: [
                Expanded(
                  child: Text(
                    titulo,
                    style: const TextStyle(
                      color: _cian,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF26324D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$valor/$valorMaximo',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                activeTrackColor: _fondoSlider,
                inactiveTrackColor: _fondoSlider,
                overlayColor: _rosa.withAlpha(40),
                thumbColor: _rosa,
                thumbShape: const _ThumbLuna(),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
                tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0),
                activeTickMarkColor: _fondoSlider,
                inactiveTickMarkColor: _fondoSlider,
              ),
              child: Slider(
                value: valor.toDouble(),
                min: 1,
                max: valorMaximo.toDouble(),
                divisions: valorMaximo - 1,
                onChanged: (nuevo) => onChanged(nuevo.round()),
                semanticFormatterCallback: (nuevo) =>
                    'Fase ' +
                    nuevo.round().toString() +
                    ' de ' +
                    valorMaximo.toString(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Fase 1',
                  style: TextStyle(color: _textoSuave, fontSize: 10),
                ),
                Text(
                  'Fase $valor/$valorMaximo',
                  style: const TextStyle(
                    color: _cian,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Fase $valorMaximo',
                  style: const TextStyle(color: _textoSuave, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ThumbLuna extends SliderComponentShape {
  const _ThumbLuna();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.square(26);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    canvas.drawCircle(
      center,
      12,
      Paint()
        ..color = _rosa.withAlpha(110)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
    canvas.drawCircle(center, 10, Paint()..color = Colors.white);
    canvas.drawCircle(center, 8, Paint()..color = _rosa);
  }
}

class _PintorLuna extends CustomPainter {
  const _PintorLuna({required this.fase, required this.totalFases});

  final int fase;
  final int totalFases;

  @override
  void paint(Canvas canvas, Size size) {
    final radio = math.min(size.width, size.height) * 0.32;
    final centro = Offset(size.width / 2, size.height / 2);
    final limites = Rect.fromCircle(center: centro, radius: radio);
    final sombra = (fase - 1) / (totalFases - 1);

    canvas.drawCircle(centro, radio, Paint()..color = _luna);
    canvas.save();
    canvas.clipPath(Path()..addOval(limites));
    canvas.drawCircle(
      Offset(centro.dx + 2 * radio * sombra, centro.dy),
      radio,
      Paint()..color = const Color(0xFF0B1226),
    );
    canvas.restore();

    canvas.drawCircle(
      centro,
      radio,
      Paint()
        ..color = _luna.withAlpha(180)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(_PintorLuna oldDelegate) {
    return fase != oldDelegate.fase || totalFases != oldDelegate.totalFases;
  }
}
