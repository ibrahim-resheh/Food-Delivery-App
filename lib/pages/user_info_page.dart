import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/providers/my_firebase_auth_provider.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatelessWidget {
  static const routeName = '/user_info_page';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final myFirebaseAuthProvider =
        Provider.of<MyFirebaseAuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('بياناتي'),
      ),
      body: Center(
        child: Container(
          width: width * 0.7,
          height: height * 0.3,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('الاسم: ${myFirebaseAuthProvider.name}', style: kTitleTextStyle.copyWith(color: Colors.white),),
              Text('الرقم: 0${myFirebaseAuthProvider.phoneNumber}', style: kTitleTextStyle.copyWith(color: Colors.white),),
              Text('العنوان: ${myFirebaseAuthProvider.address}', style: kTitleTextStyle.copyWith(color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
