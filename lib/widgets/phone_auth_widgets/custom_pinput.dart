import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/tabs_page.dart';
import 'package:food_delivery_app/providers/my_firebase_auth_provider.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import '../../my_services.dart';

class CustomPinPut extends StatelessWidget {
  BoxDecoration _pinPutDecoration(Color color, double radius) {
    return BoxDecoration(
      border: Border.all(width: 2, color: color),
      borderRadius: BorderRadius.circular(radius),
    );
  }


  @override
  Widget build(BuildContext context) {
    final myFirebaseAuthProvider = Provider.of<MyFirebaseAuthProvider>(context);
    final verificationCode = myFirebaseAuthProvider.verificationCode;
    print('pinput verification code $verificationCode');
    return PinPut(
      fieldsCount: 6,
      onSubmit: (String pin) async {
        try {
          await myFirebaseAuthProvider
              .signInUser(PhoneAuthProvider.credential(
              verificationId: verificationCode, smsCode: pin))
              .then((_) {
            Navigator.pushReplacementNamed(context, TabsPage.routeName);
          });
        } on FirebaseAuthException catch (e) {
          String message = 'حدث خطأ أثناء تسجيل الدخول، يرجى إعادة المحاولة';
          FocusScope.of(context).requestFocus(FocusNode());
          if (e.code == 'invalid-verification-code') {
            message = 'الرمز المدخل خاطئ';
          }
          if (e.code == 'network-request-failed') {
            message = 'لا يوجد اتصال بالانترنت، يرجى التأكد والمحاولة لاحقاً.';
          }
          MyServices.displayError(message, context);
        } catch (e) {
          String message = 'حدث خطأ أثناء تسجيل الدخول، يرجى إعادة المحاولة';
          MyServices.displayError(message, context);
        }
      },
      followingFieldDecoration: _pinPutDecoration(Colors.deepOrangeAccent, 5),
      selectedFieldDecoration: _pinPutDecoration(Colors.teal, 15),
      submittedFieldDecoration: _pinPutDecoration(Colors.teal, 20),
      textStyle: TextStyle(
        color: Colors.teal,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
