import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actions: [
          IconSlideAction(
            onTap: () {},
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
                    'Delete',
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
            color: Colors.white,
          ),
          margin: EdgeInsets.symmetric(vertical: 10),
          width: 352,
          height: 115,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 4,
                height: 62,
                color: Theme.of(context).primaryColor,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Play basketball',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
              Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
