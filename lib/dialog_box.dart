import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  String _title = "";

  final TextEditingController _titleController = TextEditingController();

  void initState(){

  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Dialog"),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text("Enter customized name"),
          SizedBox(
            width: 200,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
