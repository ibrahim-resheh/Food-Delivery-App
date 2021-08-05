import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/phone_auth/sign_in_page.dart';
import 'package:food_delivery_app/widgets/phone_auth_widgets/custom_sign_up_form.dart';
import 'package:food_delivery_app/widgets/phone_auth_widgets/sign_row.dart';
import 'package:food_delivery_app/widgets/phone_auth_widgets/sign_up_page_container.dart';
import '../../constants.dart';


class SignUpPage extends StatefulWidget {
  static const routeName = '/sign_up_page';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
        onTap: () {
          //to dismiss on screenKeyboard when tab outside of textField
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SignUpPageContainer(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'توصيل',
                      style: kLargeTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'إنشاء حساب جديد',
                      style: kSignTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomSignUpForm(),
                    SignRow(
                      text: 'لديك حساب مسبقاً؟',
                      textColor: Colors.white,
                      buttonText: 'قم بتسجيل الدخول',
                      destination: SignInPage.routeName,
                    ),
                    //to left the screen up as much as the bottom keyboard takes, so we can scroll down
                    Padding(padding: EdgeInsets.only(bottom: bottom)),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
