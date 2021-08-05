import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/custom_alert_dialog.dart';
import 'constants.dart';

class MyServices {
  static void displaySnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: kSnackBarTextStyle,
        ),
        duration: Duration(milliseconds: 3000),
      ),
    );
  }

  //Check if the phone number entered by user is valid
  static bool validatePhoneNumber(String phoneNumber) {
    Pattern pattern = r'^(9)?[0-9]{8}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  static void displayError(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Changa',
          ),
        ),
      ),
    );
  }

  static void displayDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => CustomAlertDialog(content: content, title: title),
    );
  }
}
