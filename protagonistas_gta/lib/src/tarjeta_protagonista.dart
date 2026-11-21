import 'package:flutter/material.dart';
import 'colores_gta.dart';
import 'protagonista.dart';

class TarjetaProtagonista extends StatelessWidget {
  final Protagonista protagonista;
  final bool activa;
  final VoidCallback? onTap;

  const TarjetaProtagonista({
    super.key,
    required this.protagonista,
    this.activa = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final acento = protagonista.colorAcento;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColoresGta.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: activa ? acento : ColoresGta.borde,
            width: activa ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: acento.withAlpha(51),
                    border: Border.all(color: acento, width: 1),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(protagonista.icono, color: acento, size: 22),
                      if (protagonista.iconoInterior != null)
                        Icon(
                          protagonista.iconoInterior,
                          color: ColoresGta.primary,
                          size: 11,
                        ),
                    ],
                  ),
                ),
                if (activa)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color.alphaBlend(acento.withAlpha(12), ColoresGta.primary),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: acento),
                    ),
                    child: Text(
                      protagonista.etiquetaActiva,
                      style: TextStyle(
                        color: acento,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              protagonista.nombre,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: activa ? Colors.white : ColoresGta.textoSecundario,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              protagonista.rol,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: ColoresGta.textoSecundario,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}