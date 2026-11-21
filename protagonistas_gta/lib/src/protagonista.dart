import 'package:flutter/material.dart';
import 'colores_gta.dart';

class Protagonista {
  final String id;
  final String nombre;
  final String rol;
  final IconData icono;
  final IconData? iconoInterior; // opcional: icono pequeño dentro del principal
  final Color colorAcento;
  final String etiquetaActiva; // "ACTIVA" / "ACTIVO" según el género

  const Protagonista({
    required this.id,
    required this.nombre,
    required this.rol,
    required this.icono,
    required this.colorAcento,
    this.iconoInterior,
    this.etiquetaActiva = 'ACTIVA',
  });

  /// Lucía, con el acento magenta del diseño.
  static const lucia = Protagonista(
    id: 'lucia',
    nombre: 'Lucía',
    rol: 'Protagonista',
    icono: Icons.account_box,
    colorAcento: ColoresGta.neonMagenta,
  );

  /// Jason, con el acento cyan y el monigote dentro del escudo.
  static const jason = Protagonista(
    id: 'jason',
    nombre: 'Jason',
    rol: 'Protagonista',
    icono: Icons.shield,
    iconoInterior: Icons.person,
    colorAcento: ColoresGta.neonCyan,
    etiquetaActiva: 'ACTIVO',
  );

  /// Los dos protagonistas del diseño, listos para usar.
  static const List<Protagonista> porDefecto = [lucia, jason];
}