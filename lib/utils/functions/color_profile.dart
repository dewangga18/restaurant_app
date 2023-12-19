import 'package:flutter/material.dart';

class ColorProfile {
  const ColorProfile._();

  static const List<Color> _colors = [
    Colors.amber,
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.indigo,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.teal,
  ];

  static final List<Color> _colorBg = [
    Colors.amber.shade100.withOpacity(0.5),
    Colors.blueAccent.shade100.withOpacity(0.5),
    Colors.blueGrey.shade100.withOpacity(0.5),
    Colors.brown.shade100.withOpacity(0.5),
    Colors.cyan.shade100.withOpacity(0.5),
    Colors.indigo.shade100.withOpacity(0.5),
    Colors.green.shade100.withOpacity(0.5),
    Colors.orange.shade100.withOpacity(0.5),
    Colors.red.shade100.withOpacity(0.5),
    Colors.teal.shade100.withOpacity(0.5),
  ];

  static Color getColorBg(int i) {
    return _colorBg[i];
  }

  static Color getColorProfile(int i) {
    return _colors[i];
  }
}
