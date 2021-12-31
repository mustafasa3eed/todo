import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/firebase.dart';
import 'package:todo/models/task.dart';
import 'package:todo/shared/network/local/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/shared/styles/theme.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'edit';
  const EditTask({Key? key}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  late task item;
  @override
  Widget build(BuildContext context) {
    item = ModalRoute.of(context)!.settings.arguments as task;
    var provider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: const Text('Task Edit'),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height *0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0,bottom: 77,left: 25.0, right: 25.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: provider.isDarkMode()? MyThemeData.primaryColorDark:Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: SingleChildScrollView(
                child: Column(
                  children:  [
                    Text('Edit Task', style: TextStyle(color: provider.isDarkMode()? Colors.white: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: TextFormField(
                              initialValue: item.title,
                              style: TextStyle(
                                color:
                                provider.isDarkMode() ? Colors.white : Colors.black,
                              ),
                              onChanged: (text) {
                                item.title = text;
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
                              maxLines: 4,
                              minLines: 4,
                              initialValue: item.description,
                              style: TextStyle(
                                color:
                                provider.isDarkMode() ? Colors.white : Colors.black,
                              ),
                              onChanged: (text) {
                                item.description = text;
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
                            height: MediaQuery.of(context).size.height * 0.04,
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
                                '${item.dateTime.day}-${item.dateTime.month}-${item.dateTime.year}',
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
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          editTask();
                        },
                        child: Text(AppLocalizations.of(context)!.save_changes))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  void taskDate() async {
    var newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (newSelectedDate != null) {
      item.dateTime = newSelectedDate;
      setState(() {});
    }
  }
  editTask(){
    editTaskDetails(item).then((value){
      Navigator.pop(context);
    });
  }

}
