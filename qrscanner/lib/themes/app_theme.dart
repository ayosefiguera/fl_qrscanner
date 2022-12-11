import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.teal;
  static const Color secundary = Colors.cyan;

  static final ThemeData mainTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    appBarTheme: const AppBarTheme(color: primary, elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0, selectedItemColor: secundary),
  );
}
