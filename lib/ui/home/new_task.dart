import 'package:flutter/material.dart';

class newTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Add a New Task',style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )),
          Container(
            margin: EdgeInsets.all(20),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )
              ),
              maxLength: 4,
            ),
          ),
          Text('Date'),
          ElevatedButton(onPressed: () {}, child: Text('Add'))
        ],
      ),
    );
  }
}
