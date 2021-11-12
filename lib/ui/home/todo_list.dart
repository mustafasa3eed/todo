import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/ui/home/todo_widget.dart';

class TodoList extends StatefulWidget {
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.white,
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
            child: ListView.builder(itemBuilder: (buildContext ,index){
              return TodoWidget();
            },
            itemCount: 20,
            ),
          )
          
        ],
      ),
    );
  }
}
