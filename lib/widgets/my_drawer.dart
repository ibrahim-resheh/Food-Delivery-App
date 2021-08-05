import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/my_services.dart';
import 'package:food_delivery_app/pages/phone_auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/tabs_page.dart';
import 'package:food_delivery_app/pages/user_info_page.dart';
import 'package:food_delivery_app/providers/my_firebase_auth_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {

  Widget _buildListTile(String text, IconData icon, BuildContext context, Function function){
    return ListTile(
      leading: Icon(icon, color: Colors.deepOrangeAccent,),
      title: Text(text, style: TextStyle(color: Colors.teal,),),
      onTap: (){
        function(context);
      },
    );
  }

  void goToHomePage(BuildContext context){
    Navigator.of(context).pushReplacementNamed(TabsPage.routeName);
  }

  void goToUserInfoPage(BuildContext context){
    Navigator.of(context).pushNamed(UserInfoPage.routeName);
  }

  void signUserOut(BuildContext context){
    try{
      Provider.of<MyFirebaseAuthProvider>(context, listen: false).signOutUser();
      Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
    } on FirebaseAuthException catch(e){
      MyServices.displayError('حدث خطأ ما أثناء تسجيل الخروج، يرجى إعادة المحاولة لاحقاً.', context);
    } catch(e){
      MyServices.displayError('حدث خطأ ما أثناء تسجيل الخروج، يرجى إعادة المحاولة لاحقاً.', context);
    }
  }


  @override
  Widget build(BuildContext context) {
    final myFirebaseAuthProvider = Provider.of<MyFirebaseAuthProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(40),
              width: double.infinity,
              color: Colors.deepOrangeAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('مرحباً', style: kTitleTextStyle.copyWith(color: Colors.white),),
                  Text('${myFirebaseAuthProvider.name}', style: kTextStyle,),
                  Text('0${myFirebaseAuthProvider.phoneNumber}', style: kPhoneNumberTextStyle.copyWith(color: Colors.white),)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildListTile('الرئيسية', Icons.home, context, goToHomePage),
                _buildListTile('بياناتي', Icons.article, context, goToUserInfoPage),
                _buildListTile('تسجيل الخروج', Icons.logout, context, signUserOut),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
