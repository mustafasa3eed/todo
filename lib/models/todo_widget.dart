import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/firebase.dart';
import 'package:todo/models/task.dart';
import 'package:todo/shared/network/local/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/modules/edit_task_screen.dart';
import 'package:todo/shared/styles/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TodoWidget extends StatelessWidget {
  task item;

  TodoWidget(this.item);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Slidable(
        actionPane: const SlidableDrawerActionPane(),
        actions: [
          IconSlideAction(
            onTap: () {
              deleteTask(item)
                  .then((value) {
                    Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!.task_deleted,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.red,
                      backgroundColor: Colors.white,
                      fontSize: 16,
                    );
                  })
                  .onError((error, stackTrace) {})
                  .timeout(const Duration(seconds: 10), onTimeout: () {});
            },
            color: Colors.transparent,
            iconWidget: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 236, 75, 75),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  Text(
                    AppLocalizations.of(context)!.delete,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, EditTask.routeName, arguments: item);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: provider.isDarkMode()
                  ? MyThemeData.primaryColorDark
                  : Colors.white,
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 352,
            height: 115,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: item.isDone
                        ? MyThemeData.greenColor
                        : Theme.of(context).primaryColor,
                  ),
                  margin: const EdgeInsets.all(10),
                  width: 4,
                  height: 62,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: item.isDone
                          ? const TextStyle(
                              color: MyThemeData.greenColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)
                          : TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.access_time,
                            color: provider.isDarkMode()
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          item.description,
                          style: item.isDone
                              ? const TextStyle(
                                  color: MyThemeData.greenColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  color: provider.isDarkMode()
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                )),
                InkWell(
                  onTap: () {
                    isDone(item);
                  },
                  child: item.isDone
                      ? Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            AppLocalizations.of(context)!.done,
                            style: const TextStyle(
                              color: MyThemeData.greenColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Container(
                          width: 69,
                          height: 34,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.all(10),
                          child: const ImageIcon(
                            const AssetImage('assets/images/icon-check.png'),
                            color: Colors.white,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
