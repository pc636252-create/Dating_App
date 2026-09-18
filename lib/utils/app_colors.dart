import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFD3A69);
  static const Color primaryDark = Color(0xFFE22F5B);
  static const Color star = Color(0xFF460BE8);
  static const Color reject = Color(0xFFBDBDBD);
  static const Color background = Color(0xFFF5F5F7);
  static const Color card = Colors.white;
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color textGrey = Color(0xFF090707);
  static const Color online = Color(0xFF4CD964);

  static const LinearGradient cardOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black87],
  );
}
