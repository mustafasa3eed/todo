import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/firebase.dart';
import 'package:todo/data/task.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/ui/home/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TodoWidget extends StatelessWidget {
  task item;

  TodoWidget(this.item);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actions: [
          IconSlideAction(
            onTap: () {
              deleteTask(item)
                  .then((value) {
                    Fluttertoast.showToast(
                      msg: 'Task deleted successfully!',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.red,
                      backgroundColor: Colors.white,
                      fontSize: 16,
                    );
                  })
                  .onError((error, stackTrace) {})
                  .timeout(Duration(seconds: 10), onTimeout: () {});
            },
            color: Colors.transparent,
            iconWidget: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 236, 75, 75),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  Text(
                    AppLocalizations.of(context)!.delete,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: provider.isDarkMode()
                ? MyThemeData.primaryColorDark
                : Colors.white,
          ),
          margin: EdgeInsets.symmetric(vertical: 10),
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
                margin: EdgeInsets.all(10),
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
                        ? TextStyle(
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
                            ? TextStyle(
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
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Done!',
                          style: TextStyle(
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
                        margin: EdgeInsets.all(10),
                        child: ImageIcon(
                          AssetImage('assets/images/icon-check.png'),
                          color: Colors.white,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
