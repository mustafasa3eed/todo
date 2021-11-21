import 'package:flutter/material.dart';
import 'package:todo/ui/home/new_task.dart';
import 'package:todo/ui/home/settings.dart';
import 'package:todo/ui/home/theme.dart';
import 'package:todo/ui/home/todo_list.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/AppConfigProvider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  @override
  int currentIndex = 0;
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: provider.isDarkMode()?MyThemeData.darkScaffoldBackground:MyThemeData.lightScaffoldBackground ,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Todo App'),
          centerTitle: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape:  StadiumBorder(
              side: BorderSide(
                  color: provider.isDarkMode()?MyThemeData.primaryColorDark:Colors.white, width:4)),
          child: const Icon(Icons.add),
          onPressed: () {
            newTaskSheet();
          },
        ),
        bottomNavigationBar:
            BottomAppBar(
              color: provider.isDarkMode()?MyThemeData.primaryColorDark:MyThemeData.primaryColor,
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              child: BottomNavigationBar(
                backgroundColor: provider.isDarkMode()?MyThemeData.primaryColorDark:Colors.white,
                elevation: 0,
                currentIndex: currentIndex,
                onTap: (index){
                  currentIndex= index;
                  setState(() {});
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  const BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
                  const BottomNavigationBarItem(icon: Icon(Icons.settings),label: ''),
                ],
              ),
            ),
        body: tabs[currentIndex],
      ),
    );
  }
  List<Widget> tabs = [
    TodoList(),
    Settings(),
  ];
  void newTaskSheet(){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
        context: context, builder: (builder){
      return
        newTask();
    });
  }

}
