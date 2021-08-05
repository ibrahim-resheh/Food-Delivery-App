import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/phone_auth/otp_page.dart';
import 'package:food_delivery_app/providers/my_firebase_auth_provider.dart';
import 'package:provider/provider.dart';
import '../../my_services.dart';
import 'custom_text_form_field.dart';

class CustomSignUpForm extends StatefulWidget {
  @override
  _CustomSignUpFormState createState() => _CustomSignUpFormState();
}

class _CustomSignUpFormState extends State<CustomSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  bool _isWaiting = false;
  bool _isUserFound = false;
  Map userInfo = {
    'name': null,
    'phoneNumber': null,
    'address': null,
  };

  Future<void> _saveForm() async {
    final myFirebaseAuth = Provider.of<MyFirebaseAuthProvider>(context, listen: false);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _isUserFound = await myFirebaseAuth.isUserExist(userInfo['phoneNumber']);
      if (_isUserFound) {
        MyServices.displayDialog(context, 'عذراً', 'هذا الرقم موجود مسبقاً');
      } else {
        await myFirebaseAuth.addUser(userInfo);
        Navigator.of(context).pushReplacementNamed(OTPPage.routeName);
        //reset isUserFound value
        _isUserFound = false;
      }
    }
  }

  @override
  void dispose() {
    _addressFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                text: 'الاسم الكامل',
                focusNode: _nameFocusNode,
                ctx: context,
                icon: Icons.person,
                validateInput: (userInput) {
                  if (userInput == '') {
                    return '* الرجاء ادخال الاسم';
                  }
                  return null;
                },
                saveInput: (userInput) {
                  userInfo['name'] = userInput;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                text: 'رقم الهاتف',
                focusNode: _phoneNumberFocusNode,
                keyboardType: TextInputType.phone,
                ctx: context,
                icon: Icons.phone,
                validateInput: (userInput) {
                  if (userInput == '') {
                    return '* الرجاء ادخال الرقم';
                  } else if (!MyServices.validatePhoneNumber(userInput)) {
                    return '* الرجاء ادخال رقم موبايل صحيح';
                  }
                  return null;
                },
                saveInput: (userInput) {
                  userInfo['phoneNumber'] = userInput;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                text: 'العنوان',
                focusNode: _addressFocusNode,
                ctx: context,
                icon: Icons.location_city,
                validateInput: (userInput) {
                  if (userInput == '') {
                    return '* الرجاء ادخال العنوان';
                  }
                  return null;
                },
                saveInput: (userInput) {
                  userInfo['address'] = userInput;
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            onPressed: () async {
              setState(() {
                _isWaiting = true;
              });
              await _saveForm();
              setState(() {
                _isWaiting = false;
              });
            },
            child: _isWaiting ? Center(child: CircularProgressIndicator(),) : Text('إنشاء حساب'),
          ),
        ),
      ],
    );
  }
}
