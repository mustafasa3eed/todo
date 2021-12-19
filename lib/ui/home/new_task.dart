import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/firebase.dart';
import 'package:todo/providers/AppConfigProvider.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  var formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Add a New Task',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
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
                    decoration: const InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
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
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Text('Select Time :',style: TextStyle(
                  color: provider.isDarkMode()?Colors.white:Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),
          InkWell(
              onTap: () {
                taskDate();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today),
                  Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    style: const TextStyle(fontSize: 18),),
                ],
              )),
          ElevatedButton(
              onPressed: () {
                addToDo();
              },
              child: const Text('Add'))
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
    }).timeout(const Duration(seconds: 10),onTimeout: (){

    });
  }

  void taskDate() async {
    var newSelectedDate = await
    showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      setState(() {
      });
    }
  }
}
