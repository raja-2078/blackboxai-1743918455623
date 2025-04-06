import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade800,
      secondary: Colors.orange.shade600,
      background: Colors.grey.shade100,
    ),
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.blue.shade300,
      secondary: Colors.orange.shade400,
      background: Colors.grey.shade900,
    ),
    useMaterial3: true,
  );
}