import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/ui/home/edit_task_screen.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/home/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (buildContext) {
        return AppConfigProvider();
      },
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;
  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (buildContext) => const HomeScreen(),
        EditTask.routeName: (buildContext) => const EditTask(),
      },
      initialRoute: HomeScreen.routeName,
      title: 'TODO App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
    );
  }

  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    provider.changeLanguage(prefs.getString('language') ?? 'en');
    if (prefs.getString('theme') == 'light') {
      provider.changeTheme(ThemeMode.light);
    } else if (prefs.getString('theme') == 'dark') {
      provider.changeTheme(ThemeMode.dark);
    }
  }
}
