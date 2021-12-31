import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/firebase.dart';
import 'package:todo/shared/network/local/app_config_provider.dart';
import 'package:todo/shared/styles/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: provider.isDarkMode()
                ? MyThemeData.primaryColorDark
                : Colors.white,
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),

            Text(AppLocalizations.of(context)!.sheet,
                style: TextStyle(
                  color: provider.isDarkMode() ? Colors.white : Colors.black,
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
                      style: TextStyle(
                        color:
                            provider.isDarkMode() ? Colors.white : Colors.black,
                      ),
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (textValue) {
                        if (textValue == null || textValue.isEmpty) {
                          return AppLocalizations.of(context)!.title_validation;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.title,
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: provider.isDarkMode()
                                ? Colors.white24
                                : Colors.black38,
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: TextFormField(
                      style: TextStyle(
                        color:
                            provider.isDarkMode() ? Colors.white : Colors.black,
                      ),
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (textValue) {
                        if (textValue == null || textValue.isEmpty) {
                          return AppLocalizations.of(context)!.details_validation;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.details,
                          labelStyle: TextStyle(
                            color: provider.isDarkMode()
                                ? Colors.white24
                                : Colors.black38,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.task_time,
                    style: TextStyle(
                        color: provider.isDarkMode()
                            ? Colors.white24
                            : Colors.black38,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  )
                ],
              ),
            ),
            InkWell(
                onTap: () {
                  taskDate();
                },
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                        style: TextStyle(
                          fontSize: 18,
                          color:
                              provider.isDarkMode() ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  addToDo();
                },
                child: Text(AppLocalizations.of(context)!.add)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),

          ],
        ),
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
    }).timeout(const Duration(seconds: 10), onTimeout: () {});
  }

  void taskDate() async {
    var newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      setState(() {});
    }
  }
}
