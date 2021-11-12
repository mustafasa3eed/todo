import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,

      ),
      margin: EdgeInsets.all(10),
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
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Play basketball',style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),)
            ],
          )),
          Container(
            width: 69,
            height: 34,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8)
            ),
            margin: EdgeInsets.all(10),
            child: Icon(Icons.check,
          color: Colors.white,),)
        ],
      ),
    );
  }
}
