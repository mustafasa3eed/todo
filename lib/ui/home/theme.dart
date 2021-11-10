import 'package:flutter/material.dart';

class MyThemeData{
  static const Color lightScaffoldBacground =
  Color.fromARGB(255,223,236,219);
  static final ThemeData lightTheme =
      ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: lightScaffoldBacground,
      );
}