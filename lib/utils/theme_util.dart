import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

final lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'ic_font',
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
        color: Color(0xff293241),
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'ic_font'),
  ),
  colorScheme: ColorScheme.light(
    primary: Color(0xff293241),
    secondary: Color(0xffE0FBFC),
    surface: Color(0xFF3D5A80),
    background: Colors.white,
  ),
);

final darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'ic_font',
  scaffoldBackgroundColor: Color(0xff293241),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff293241),
    elevation: 0,
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'ic_font'),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    secondary: Color(0xffE0FBFC),
    surface: Color(0xFF3D5A80),
    background: Color(0xff293241),
  ),
);
