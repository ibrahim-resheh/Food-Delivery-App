import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';


class MyErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/error.jpg'),
        Text(
          'حدث خطأ ما، يرجى إعادة المحاولة.',
          style: kTextStyle.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
