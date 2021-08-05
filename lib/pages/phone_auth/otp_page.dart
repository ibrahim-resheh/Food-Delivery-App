import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/my_firebase_auth_provider.dart';
import 'package:food_delivery_app/widgets/custom_alert_dialog.dart';
import 'package:food_delivery_app/widgets/phone_auth_widgets/custom_pinput.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class OTPPage extends StatelessWidget {
  static const routeName = '/otp_page';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: Provider.of<MyFirebaseAuthProvider>(context, listen: false).verifyPhoneNumber(context),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.hasError) {
            return CustomAlertDialog(content: 'حدث خطأ ما، يرجى إعادة المحاولة.', title: 'عذراً');
          }
          return SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 120,
                  horizontal: 40,
                ),
                child: Column(
                  children: [
                    Text(
                      'تم إرسال رمز التحقق إلى الرقم:',
                      style: kSignTextStyle,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Consumer<MyFirebaseAuthProvider>(
                      builder: (ctx, myFirebaseAuth, child) => Text(
                        '+963 ${myFirebaseAuth.phoneNumber}',
                        textDirection: TextDirection.ltr,
                        style: kPhoneNumberTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomPinPut(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}