import 'package:flutter/material.dart';

class SignUpPageContainer extends StatelessWidget {
  final Widget child;

  SignUpPageContainer({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.only(
          //topLeft: Radius.circular(200),
          bottomRight: Radius.circular(300),
        ),
      ),
      child: child,
    );
  }
}
