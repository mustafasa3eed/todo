import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/data/firebase.dart';
import 'package:todo/data/task.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:todo/ui/home/theme.dart';
import 'package:todo/ui/home/todo_widget.dart';
import 'package:provider/provider.dart';


class TodoList extends StatefulWidget {
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      child: Column(
        children: [
          Container(
            color: provider.isDarkMode()?MyThemeData.primaryColorDark:Colors.white,
            child: TableCalendar(
              selectedDayPredicate: (day) {
               return isSameDay(day,selectedDay);
              },
              onDaySelected: (sDay, fDay) {
                setState(() {
                  selectedDay = sDay;
                  focusedDay = fDay;
                });
              },
              focusedDay: focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 365)),
              calendarFormat: CalendarFormat.week,
              weekendDays: [],
              calendarStyle: CalendarStyle(
                  selectedTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  todayTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                  todayDecoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.5,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  defaultDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  defaultTextStyle: TextStyle(
                    color: Colors.black,
                  )),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: StreamBuilder<QuerySnapshot<task>>(
                stream: getTasks().snapshots(),
                builder: (BuildContext buildContext,AsyncSnapshot<QuerySnapshot<task>> snapshot ){
                  if(snapshot.hasError){
                   return Text(snapshot.error.toString());
                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  List<task> item = snapshot.data!.docs.map((e) => e.data()).toList();
                  return ListView.builder(itemBuilder: (buildContext, index){
                    return TodoWidget(item[index]);
                  },
                  itemCount: item.length,);
              }
              ),
            )
            ),
        ],
      ),
    );
  }
}
