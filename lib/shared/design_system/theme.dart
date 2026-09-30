import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ftc_os/shared/design_system/tokens.dart';

ThemeData buildTheme(Brightness brightness, {ColorScheme? dynamicScheme}) {
  final scheme = dynamicScheme ??
      ColorScheme.fromSeed(seedColor: Brand.seed, brightness: brightness);
  final base = ThemeData(useMaterial3: true, colorScheme: scheme);
  return base.copyWith(
    textTheme: GoogleFonts.interTextTheme(base.textTheme),
    cardTheme: CardThemeData(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.card)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(Radii.field)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.field)),
      ),
    ),
  );
}
