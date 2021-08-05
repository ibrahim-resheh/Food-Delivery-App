import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  CustomAlertDialog({
    @required this.content,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: Colors.teal),
      ),
      content: Text(
        content,
        style: TextStyle(color: Colors.teal),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'موافق',
            style: TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
