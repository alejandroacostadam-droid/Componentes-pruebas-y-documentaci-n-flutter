import 'package:flutter/material.dart';
import 'colores_gta.dart';
import 'protagonista.dart';
import 'tarjeta_protagonista.dart';

class SelectorProtagonistas extends StatelessWidget {
  final String titulo;
  final List<Protagonista> protagonistas;
  final String? idActivo;
  final ValueChanged<Protagonista> onSeleccionado;

  const SelectorProtagonistas({
    super.key,
    this.titulo = 'PROTAGONISTAS',
    required this.protagonistas,
    required this.onSeleccionado,
    this.idActivo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: ColoresGta.neonMagenta,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            for (int i = 0; i < protagonistas.length; i++) ...[
              if (i > 0) const SizedBox(width: 12),
              Expanded(
                child: TarjetaProtagonista(
                  protagonista: protagonistas[i],
                  activa: protagonistas[i].id == idActivo,
                  onTap: () => onSeleccionado(protagonistas[i]),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}