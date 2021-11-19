import 'package:flutter/material.dart';

class newTask extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Add a New Task'),
        Container(
          margin: EdgeInsets.all(20),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Description',
            ),
            maxLength: 4,
          ),
        ),
        Text('Date'),
        ElevatedButton(onPressed: (){}, child: Text('Add'))
      ],
    );
  }
}
