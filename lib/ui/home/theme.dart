import 'package:flutter/material.dart';

class MyThemeData{
  static const Color primaryColor = Color.fromARGB(255, 183, 147, 95);
  static const Color primaryColorDark = Color.fromARGB(255, 20, 26, 46);
  static const Color lightScaffoldBackground =
  Color.fromARGB(255,223,236,219);
  static final ThemeData lightTheme =
      ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: lightScaffoldBackground,
      );
  static const Color darkScaffoldBackground = 
      Color.fromARGB(255, 6, 14, 30);
  static final ThemeData darkTheme =
      ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: darkScaffoldBackground,


      );
}