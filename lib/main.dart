import 'package:flutter/material.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/ui/home/theme.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.routeName:(buildContext)=> HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
      title: 'Flutter Demo',
      theme: MyThemeData.lightTheme,
    );
  }
}


