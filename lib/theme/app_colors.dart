import 'package:flutter/material.dart';

/// Colores de la aplicación Travello
abstract final class AppColors {
  /// Color principal - #FF3851
  static const Color primary = Color(0xFFFF3851);

  /// Color secundario - #FF7686
  static const Color secondary = Color(0xFFFF7686);

  /// Color terciario - #252525
  static const Color tertiary = Color(0xFF252525);

  /// Color cuaternario - blanco puro
  static const Color quaternary = Color(0xFFFFFFFF);

  /// Gris - #C4C4C4 al 20% de opacidad
  static const Color gray = Color(0x33C4C4C4);

  /// Negro al 50% de opacidad
  static const Color black50 = Color(0x80000000);

  /// Acento turquesa - #14B8A6 (mar, cielo, sensación de viaje)
  static const Color accent = Color(0xFF14B8A6);

  /// Destacado ámbar - #F59E0B (sol, ofertas, elementos premium)
  static const Color highlight = Color(0xFFF59E0B);
}
