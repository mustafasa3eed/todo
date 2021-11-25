import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/firebase.dart';
import 'package:todo/data/task.dart';
import 'package:todo/providers/AppConfigProvider.dart';
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
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: CalendarTimeline(
            initialDate: selectedDay,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) => print(date),
            leftMargin: 20,
            monthColor: Colors.blueGrey,
            dayColor: Colors.teal[200],
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: Color(0xFF333A47),
            selectableDayPredicate: (date) => date.day != 23,
          )
        ),
        Expanded(
            child: Scrollbar(
          child: StreamBuilder<QuerySnapshot<task>>(
              stream: getTasks().where('dateTime',isEqualTo: selectedDay.millisecondsSinceEpoch).snapshots(),
              builder: (BuildContext buildContext,
                  AsyncSnapshot<QuerySnapshot<task>> snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                List<task> item =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  itemBuilder: (buildContext, index) {
                    return TodoWidget(item[index]);
                  },
                  itemCount: item.length,
                );
              }),
        )),
      ],
    );
  }
}
