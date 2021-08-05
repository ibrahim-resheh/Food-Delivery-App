import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/phone_auth/sign_up_page.dart';
import 'package:food_delivery_app/widgets/phone_auth_widgets/sign_in_form.dart';
import 'package:food_delivery_app/widgets/phone_auth_widgets/sign_in_page_container.dart';
import 'package:food_delivery_app/widgets/phone_auth_widgets/sign_row.dart';


import '../../constants.dart';

class SignInPage extends StatelessWidget {
  static const routeName = '/';

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
        backgroundColor: Colors.deepOrangeAccent,
        body: SafeArea(
          child: SignInPageContainer(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'توصيل',
                    style: kLargeTextStyle,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'تسجيل الدخول',
                    style: kSignTextStyle,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SignInForm(),
                  SignRow(
                    text: 'ليس لديك حساب؟',
                    textColor: Colors.deepOrangeAccent,
                    buttonText: 'إنشاء حساب',
                    destination: SignUpPage.routeName,
                  ),
                  //to left the screen up as much as the bottom keyboard takes, so we can scroll down
                  Padding(padding: EdgeInsets.only(bottom: bottom)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
