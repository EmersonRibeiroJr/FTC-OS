import 'package:flutter/material.dart';

/// Tokens do Design System (grade de 4 px).
abstract final class Space {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double huge = 48;
}

abstract final class Radii {
  static const double field = 8;
  static const double chip = 12;
  static const double card = 16;
  static const double sheet = 24;
}

abstract final class Motion {
  static const fast = Duration(milliseconds: 100);
  static const base = Duration(milliseconds: 200);
  static const slow = Duration(milliseconds: 300);
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
}

abstract final class Brand {
  static const Color seed = Color(0xFF4F46E5);
}

/// Classes de largura (breakpoints Material 3).
enum WindowClass {
  compact,
  medium,
  expanded;

  static WindowClass of(double width) => width < 600
      ? compact
      : width < 840
          ? medium
          : expanded;
}
