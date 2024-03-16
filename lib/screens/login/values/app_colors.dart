import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primaryColor = Color(0xffBAE162);
  static const Color darkBlue = Color.fromARGB(255, 248, 0, 0);
  static const Color darkerBlue = Color.fromARGB(255, 27, 207, 183);
  static const Color darkestBlue = Color.fromARGB(255, 0, 0, 0);

  static const List<Color> defaultGradient = [
    darkBlue,
    darkerBlue,
    darkestBlue,
  ];
}
