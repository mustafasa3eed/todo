import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/ui/home/theme.dart';
import 'package:todo/ui/settings/theme_menu.dart';
import 'package:todo/ui/settings/language_menu.dart';


class Settings extends StatefulWidget {

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(AppLocalizations.of(context)!.language,
            style: TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 25,
                color: provider.isDarkMode()?Colors.white:Colors.black ),),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: provider.isDarkMode()?Colors.blue:Colors.transparent),
            color: provider.isDarkMode()?Colors.transparent:Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(provider.appLanguage=='en'?"English":"العربية",
                style: TextStyle(
                  fontSize: 20,
                  color: provider.isDarkMode()?Colors.blue:MyThemeData.primaryColor,
                ),),
              IconButton(onPressed: (){
                ShowLanguageMenu();
              }, icon: Icon(Icons.arrow_drop_down_sharp,
                color: provider.isDarkMode()?Colors.blue:MyThemeData.primaryColor
                ,))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(AppLocalizations.of(context)!.theme,
            style: TextStyle(
                fontSize: 25,
                color: provider.isDarkMode()?Colors.white:Colors.black,
              fontWeight: FontWeight.bold
            ),),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: provider.isDarkMode()?Colors.blue:Colors.transparent),
            color: provider.isDarkMode()?Colors.transparent:Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(provider.appTheme == ThemeMode.light?
              AppLocalizations.of(context)!.light
                  :AppLocalizations.of(context)!.dark,
                style: TextStyle(
                    fontSize: 20,
                    color: provider.isDarkMode()?Colors.blue:MyThemeData.primaryColor
                ),),
              IconButton(onPressed: (
                  ){
                ShowThemeMenu();
              }, icon: Icon(Icons.arrow_drop_down_sharp,
                color:provider.isDarkMode()?Colors.blue:Colors.black ,
              ))
            ],
          ),
        ),
      ],
    );
  }

  void ShowLanguageMenu() {
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (builder){
           return LanguageMenu();
        });
  }
  void ShowThemeMenu() {
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (builder){
          return ThemeMenu();
        });
  }
}
