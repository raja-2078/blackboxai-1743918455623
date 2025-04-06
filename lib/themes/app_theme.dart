import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<String>((ref) => 'System Default');

class AppTheme {
  static ThemeData getTheme(String themeMode) {
    switch (themeMode) {
      case 'Light':
        return lightTheme;
      case 'Dark':
        return darkTheme;
      default:
        return ThemeData.light();
    }
  }

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade800,
      secondary: Colors.orange.shade600,
      surface: Colors.grey.shade100,
    ),
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.blue.shade300,
      secondary: Colors.orange.shade400,
      surface: Colors.grey.shade900,
    ),
    useMaterial3: true,
  );
}
