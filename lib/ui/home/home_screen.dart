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

  int currentIndex = 0;
  @override
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8)
              ),
              child: BottomAppBar(
                color: provider.isDarkMode()?MyThemeData.primaryColorDark:Colors.white,
                shape: const CircularNotchedRectangle(),
                notchMargin: 8,
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
                    const BottomNavigationBarItem(icon: Icon(Icons.list,size: 33,), label: ''),
                    const BottomNavigationBarItem(icon: Icon(Icons.settings_outlined, size: 33,),label: ''),
                  ],
                ),
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
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context:context,
      builder:(BuildContext context){
        return(
            const NewTask()
        );
    });
  }

}
