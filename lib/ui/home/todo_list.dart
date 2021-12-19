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
  static late DateTime selectedDay;
  DateTime initialDay = DateTime.now();
  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          child: CalendarTimeline(
            showYears: true,
            initialDate: selectedDay,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                selectedDay = date!;
              });
            },
            leftMargin: 20,
            monthColor: Colors.white70,
            dayColor: Colors.teal[200],
            dayNameColor: Color(0xFF333A47),
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: Color(0xFF333A47),
            selectableDayPredicate: (date) => date.day != 0,
            locale: 'en',
          ),
        ),
        // Container(
        //   color: Colors.blue,
        //   child: DatePicker(
        //     DateTime.now(),
        //     initialSelectedDate: DateTime.now(),
        //     selectionColor: Colors.black,
        //     selectedTextColor: Colors.white,
        //     daysCount:  15,
        //     onDateChange: (date) {
        //       // New date selected
        //       setState(() {
        //         selectedDay = date;
        //       });
        //     },
        //   ),
        // ),
        Expanded(
          child: Scrollbar(
            child: StreamBuilder<QuerySnapshot<task>>(
                stream: getTasks()
                .where('dateTime',isEqualTo: selectedDay.getDateOnly().millisecondsSinceEpoch)
                    .snapshots(),
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
          ),
        ),
      ],
    );
  }
}
