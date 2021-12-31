import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }

  void changeTheme(ThemeMode newMode) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(newMode == appTheme) return;
    appTheme = newMode;
    prefs.setString('theme', newMode == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }

  void changeLanguage (String newLang) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newLang == appLanguage) return;
    appLanguage = newLang;
    prefs.setString('language', newLang);
    notifyListeners();

  }
}