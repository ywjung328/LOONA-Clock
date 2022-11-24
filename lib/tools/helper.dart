import 'package:flutter/material.dart';

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount)!;
  }

  Color increaseColorSaturation(double increment) {
    var hslColor = HSLColor.fromColor(this);
    var newValue = min(max(hslColor.saturation + increment, 0.0), 1.0);
    return hslColor.withSaturation(newValue).toColor();
  }

  Color increaseColorLightness(double increment) {
    var hslColor = HSLColor.fromColor(this);
    var newValue = min(max(hslColor.lightness + increment, 0.0), 1.0);
    return hslColor.withLightness(newValue).toColor();
  }

  Color increaseColorHue(double increment) {
    var hslColor = HSLColor.fromColor(this);
    var newValue = min(max(hslColor.hue + increment, 0.0), 360.0);
    return hslColor.withHue(newValue).toColor();
  }
}

double min(double a, double b) => a < b ? a : b;
double max(double a, double b) => a > b ? a : b;
