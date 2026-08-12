import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color(0xFF2E7D32);
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.light),
    scaffoldBackgroundColor: const Color(0xFFF8FAF8),
    appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    ),
  );
}
