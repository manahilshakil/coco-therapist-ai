import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkTheme = false;

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  ThemeData get currentTheme => isDarkTheme ? _darkTheme : _lightTheme;

  // ---------------- LIGHT THEME ----------------
  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF7F5F2), // soft beige-white
    primaryColor: const Color(0xFF8C6E54), // soft brown
    cardColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF3EFEA),
      elevation: 1,
      foregroundColor: Colors.black,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
    ),
    colorScheme: const ColorScheme.light(
      secondary: Color(0xFF8C6E54),
    ),
    useMaterial3: true,
  );

  // ---------------- DARK THEME ----------------
  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1C1C27),
    primaryColor: const Color(0xFFBFA5FF), // soft violet
    cardColor: const Color(0xFF2A2A38),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2E2A40),
      elevation: 1,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFE0DEF7)),
    ),
    colorScheme: const ColorScheme.dark(
      secondary: Color(0xFFBFA5FF),
    ),
    useMaterial3: true,
  );
}
