import 'package:flutter/material.dart';

class SignInPageContainer extends StatelessWidget {
  final Widget child;

  SignInPageContainer({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(200),
          bottomRight: Radius.circular(200),
        ),
      ),
      child: child,
    );
  }
}
