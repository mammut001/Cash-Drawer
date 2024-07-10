import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _titleController.text = "";
  }
  @override
  void dispose(){
    _titleController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Alert Box"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text("Enter customized name"),
          SizedBox(
            width: 200,
            child: TextField(
              controller: _titleController,
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
          onPressed: () => Navigator.pop(context, _titleController.text),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
