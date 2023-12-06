// themeModeData.dart

import 'package:flutter/material.dart';

enum ThemeModeOption { green, yellow, blue }

class ThemeModeData extends ChangeNotifier {
  ThemeModeOption _selectedOption = ThemeModeOption.green;

  ThemeModeOption get selectedOption => _selectedOption;

  void setThemeModeOption(ThemeModeOption option) {
    _selectedOption = option;
    notifyListeners();
  }

  ThemeData getTheme() {
    switch (_selectedOption) {
      case ThemeModeOption.green:
        return _greenTheme;
      case ThemeModeOption.yellow:
        return _yellowTheme;
      case ThemeModeOption.blue:
        return _blueTheme;
      default:
        return _greenTheme;
    }
  }

  static MaterialColor createMaterialColor(int r, int g, int b) {
    // Mendapatkan warna utama dari nilai RGB
    Map<int, Color> color = {
      50: Color.fromRGBO(r, g, b, 0.1),
      100: Color.fromRGBO(r, g, b, 0.2),
      200: Color.fromRGBO(r, g, b, 0.3),
      300: Color.fromRGBO(r, g, b, 0.4),
      400: Color.fromRGBO(r, g, b, 0.5),
      500: Color.fromRGBO(r, g, b, 0.6),
      600: Color.fromRGBO(r, g, b, 0.7),
      700: Color.fromRGBO(r, g, b, 0.8),
      800: Color.fromRGBO(r, g, b, 0.9),
      900: Color.fromRGBO(r, g, b, 1),
    };

    return MaterialColor(Color.fromRGBO(r, g, b, 1).value, color);
  }

  static final MaterialColor _greenSwatch = createMaterialColor(70, 152, 138);
  static final MaterialColor _yellowSwatch = createMaterialColor(255,192,27);
  static final MaterialColor _blueSwatch = createMaterialColor(82, 140, 255);

  static final ThemeData _greenTheme = ThemeData(
    primaryColor: const Color.fromRGBO(70, 152, 138, 1),
    primarySwatch: _greenSwatch,
  );

  static final ThemeData _yellowTheme = ThemeData(
    primaryColor: const Color.fromRGBO(255,192,27, 1),
    primarySwatch: _yellowSwatch,
  );

  static final ThemeData _blueTheme = ThemeData(
    primaryColor: const Color.fromRGBO(82, 140, 255, 1),
    primarySwatch: _blueSwatch,
  );
}
