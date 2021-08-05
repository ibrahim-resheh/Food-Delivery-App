import 'package:flutter/material.dart';
import 'package:food_delivery_app/my_services.dart';
import 'package:food_delivery_app/pages/phone_auth/otp_page.dart';
import 'package:food_delivery_app/providers/my_firebase_auth_provider.dart';
import 'package:provider/provider.dart';
import '../custom_alert_dialog.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController _controller = TextEditingController();
  bool _isWaiting = false;

  Future<void> _signInUser(String phoneNumber, BuildContext context) async {
    final myFirebaseAuth =
        Provider.of<MyFirebaseAuthProvider>(context, listen: false);
    bool isUserFound = false;
    isUserFound = await myFirebaseAuth.isUserExist(phoneNumber);
    if (isUserFound) {
      try {
        await myFirebaseAuth.fetchUserInfo(phoneNumber);
        Navigator.of(context).pushReplacementNamed(OTPPage.routeName);
      } catch (error) {
        MyServices.displayError('حدث خطأ ما.', context);
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
                content: 'هذا الرقم غير موجود.',
                title: 'عذراً',
              ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          style: TextStyle(
            height: 1,
            fontSize: 16,
            color: Colors.teal,
          ),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'رقم الهاتف',
            labelStyle: TextStyle(
              color: Colors.deepOrangeAccent,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(
                color: Colors.deepOrangeAccent,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(
                color: Colors.teal,
                width: 2,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            onPressed: () async {
              setState(() {
                _isWaiting = true;
              });
              if (MyServices.validatePhoneNumber(_controller.text)) {
                await _signInUser(_controller.text, context);
              } else {
                MyServices.displayError('الرجاء إدخال رقم بشكل صحيح.', context);
              }
              setState(() {
                _isWaiting = false;
              });
            },
            child: _isWaiting ? Center(child: CircularProgressIndicator(),) : Text('تسجيل الدخول'),
          ),
        ),
      ],
    );
  }
}
