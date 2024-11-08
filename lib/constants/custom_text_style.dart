import 'package:flutter/material.dart';

TextStyle customTextStyle({
  double fontSize = 16.0,
  FontWeight fontWeight = FontWeight.bold,
  Color color = Colors.black,
  double letterSpacing = 0.0,
  double height = 1.0,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    letterSpacing: letterSpacing,
    height: height,
  );
}
