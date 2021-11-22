import 'package:flutter/material.dart';
import 'package:todo/data/firebase.dart';

class newTask extends StatefulWidget {
  @override
  State<newTask> createState() => _newTaskState();
}

class _newTaskState extends State<newTask> {
  var formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 120,left: 20,right: 20),
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Add a New Task',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextFormField(
                    onChanged: (text){
                      title = text;
                    },
                    validator: (textValue) {
                      if (textValue == null || textValue.isEmpty) {
                        return 'Please enter task title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextFormField(
                    onChanged: (text){
                      description = text;
                    },
                    validator: (textValue) {
                      if (textValue == null || textValue.isEmpty) {
                        return 'Please enter task description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
              onTap: () {
                taskDate();
              },
              child: Row(
                children: [
                  Icon(Icons.edit),
                  Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    style: TextStyle(fontSize: 18),),
                ],
              )),
          ElevatedButton(
              onPressed: () {
                addToDo();
              },
              child: Text('Add'))
        ],
      ),
    );
  }

  void addToDo() {
    if (!formkey.currentState!.validate()) {
      return;
    }
    pushToFirestore(title, description, selectedDate).then((value) {
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      "Can't add your task, please try again";
    }).timeout(Duration(seconds: 10),onTimeout: (){

    });
  }

  void taskDate() async {
    var newSelectedDate = await
    showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      setState(() {
      });
    }
  }
}
