import 'package:flutter/material.dart';

class Warning extends StatelessWidget {
  final String msg;

  Warning({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: const Text("Alert"),
      content: Text(msg),
      actions: <Widget>[
        TextButton(onPressed: () => Navigator.pop(context), child: Text("OK")
        )
      ],
    );
  }
}

