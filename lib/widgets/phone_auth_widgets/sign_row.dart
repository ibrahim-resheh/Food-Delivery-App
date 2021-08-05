import 'package:flutter/material.dart';

class SignRow extends StatelessWidget {
  final String text;
  final String buttonText;
  final String destination;
  final Color textColor;

  SignRow({
    @required this.text,
    @required this.buttonText,
    @required this.destination,
    @required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(destination);
          },
          child: Text(buttonText),
        ),
      ],
    );
  }
}
