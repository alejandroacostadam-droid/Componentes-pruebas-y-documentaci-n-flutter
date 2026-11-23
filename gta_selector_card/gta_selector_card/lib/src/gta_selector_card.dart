import 'package:flutter/material.dart';

/// Muestra un título, una etiqueta a la derecha con la opción elegida
/// (p. ej. "GTA VI") y una fila de botones circulares. Al pulsar uno,
/// se resalta y se notifica a la app mediante [onChanged].
class GtaSelectorCard extends StatefulWidget {
  const GtaSelectorCard({
    super.key,
    this.options = const ['I', 'II', 'III', 'IV', 'V', 'VI'],
    this.initialIndex = 5,
    this.barraAzul = const Color(0xFF00E5FF),
    this.rosa = const Color(0xFFFF2D8A), // rosa: opción elegida
    this.degradadoInicial = const Color(0xFF16213E), // inicio del degradado
    this.degradadoFinal = const Color(0xFF0F1830), // final del degradado
    this.circuloVacio = const Color(0xFF0B1226), // fondo de círculos
    this.onChanged,
  })  : assert(options.length > 0, 'Debe haber al menos una opción'),
        assert(initialIndex >= 0 && initialIndex < options.length,
            'initialIndex fuera de rango');
  final List<String> options;
  final int initialIndex;

  final Color barraAzul;
  final Color rosa;
  final Color degradadoInicial;
  final Color degradadoFinal;
  final Color circuloVacio;

  final ValueChanged<int>? onChanged;

  @override
  State<GtaSelectorCard> createState() => _GtaSelectorCardState();
}

class _GtaSelectorCardState extends State<GtaSelectorCard> {
  //Valor por defecto del componente
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // Cambia la selección y avisa a la aplicación mediante el callback.
  void _select(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    widget.onChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Degradado diagonal azul oscuro
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [widget.degradadoInicial, widget.degradadoFinal],
        ),
        borderRadius: BorderRadius.circular(16),
        // Borde fino y sutil que separa la tarjeta del fondo de la pantalla
        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildOptions(),
        ],
      ),
    );
  }

  // Cabecera: barra de acento + título a la izquierda y etiqueta a la derecha.
  Widget _buildHeader() {
    return Row(
      children: [
        // Barrita vertical con brillo
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: widget.barraAzul,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: widget.barraAzul.withValues(alpha: 0.6),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '¿QUÉ GTA TE GUSTÓ MÁS?',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Etiqueta con la opción elegida, p. ej. "GTA VI"
        Text(
          'GTA ${widget.options[_selectedIndex]}',
          style: TextStyle(
            color: widget.barraAzul,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Fila de círculos, uno por cada opción.
  Widget _buildOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < widget.options.length; i++) _buildCircle(i),
      ],
    );
  }

  /// Un círculo individual; cambia de aspecto si está seleccionado.
  Widget _buildCircle(int index) {
    final bool selected = index == _selectedIndex;

    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: () => _select(index),
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // Seleccionado: tinte rosa; resto: fondo oscuro
            color: selected
                ? widget.rosa.withValues(alpha: 0.12)
                : widget.circuloVacio,
            // Seleccionado: borde rosa; resto: borde casi invisible
            border: Border.all(
              color: selected ? widget.rosa : Colors.white,
              width: selected ? 2 : 1,
            ),
            // Brillo solo en el seleccionado
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: widget.rosa.withValues(alpha: 0.45),
                      blurRadius: 10,
                    ),
                  ]
                : null,
          ),
          child: Text(
            widget.options[index],
            style: TextStyle(
              color: selected ? widget.rosa : Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
