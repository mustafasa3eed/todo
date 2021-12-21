import 'package:flutter/material.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/ui/home/theme.dart';

class ThemeMenu extends StatefulWidget {
  @override
  State<ThemeMenu> createState() => _ThemeMenuState();
}

class _ThemeMenuState extends State<ThemeMenu> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      margin: EdgeInsets.only(left: 20,right: 20, bottom: 200),
      height: 100,
      decoration: BoxDecoration(
        color: provider.isDarkMode()?MyThemeData.primaryColorDark:Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
            child: provider.isDarkMode()
                ? unSelectedTheme(
                AppLocalizations.of(context)!.light)
                : selectedTheme(
                AppLocalizations.of(context)!.light),
          ),
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
            child: provider.isDarkMode()
                ? selectedTheme(
                AppLocalizations.of(context)!.dark)
                : unSelectedTheme(
                AppLocalizations.of(context)!.dark),
          )
        ],
      ),
    );
  }

  Widget selectedTheme(String text){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text (text,style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
          )),
          Icon(Icons.check,color: Theme.of(context).primaryColor,),
        ],
      ),
    );
  }

  Widget unSelectedTheme(String text){
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text (text,style: TextStyle(
              fontSize: 20,
            color: provider.isDarkMode()?Colors.white:Colors.black
          )),
        ],
      ),
    );
  }
}
