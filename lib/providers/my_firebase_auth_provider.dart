import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../my_services.dart';

class MyFirebaseAuthProvider with ChangeNotifier {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  String _id;
  String _name;
  String _phoneNumber;
  String _address;
  String _verificationCode;

  String get id => _id;

  String get name => _name;

  String get phoneNumber => _phoneNumber;

  String get address => _address;

  String get verificationCode => _verificationCode;

  Future<void> addUser(Map userInfo) async {
    await users.add({
      'name': userInfo['name'],
      'phoneNumber': userInfo['phoneNumber'],
      'address': userInfo['address'],
    }).catchError((error) {
      throw error;
    }).then((_) async {
      QuerySnapshot snapshot = await users
          .where('phoneNumber', isEqualTo: userInfo['phoneNumber'])
          .get();
      _id = snapshot.docs[0].id;
      _name = userInfo['name'];
      _phoneNumber = userInfo['phoneNumber'];
      _address = userInfo['address'];
      print('$_id $_name $_phoneNumber $_address');
      notifyListeners();
    });
  }

  Future<bool> isUserExist(String phoneNumber) async {
    QuerySnapshot querySnapshot =
        await users.where('phoneNumber', isEqualTo: phoneNumber).get();
    if (querySnapshot.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> fetchUserInfo(String phoneNumber) async {
    try{
      QuerySnapshot snapshot = await users.where('phoneNumber', isEqualTo: phoneNumber).get();
      _id = snapshot.docs[0].id;
      _name = snapshot.docs[0].data()['name'];
      _phoneNumber = snapshot.docs[0].data()['phoneNumber'];
      _address = snapshot.docs[0].data()['address'];
      print('$_id $_name $_phoneNumber $_address');
    }catch(error){
      throw error;
    }

  }

  Future<void> signInUser(AuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then((_) {
        print(FirebaseAuth.instance.currentUser.uid);
      });
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (error) {
      throw error;
    }
  }

  Future<void> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      _id = null;
      _phoneNumber = null;
      _address = null;
      _name = null;
      _verificationCode = null;
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (error) {
      throw error;
    }
  }

  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+963$_phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await signInUser(credential).then((_) {
            print(FirebaseAuth.instance.currentUser.uid);
          });
        } on FirebaseAuthException catch (e) {
          String message = 'حدث خطأ أثناء تسجيل الدخول، يرجى المحاولة لاحقاً.';
          if (e.code == 'network-request-failed') {
            message = 'لا يوجد اتصال بالانترنت، يرجى التأكد والمحاولة لاحقاً.';
          }
          if (e.code == 'invalid-verification-code') {
            message = 'الرمز المدخل خاطئ';
          }
          MyServices.displayError(message, context);
        } catch (error) {
          String message = 'حدث خطأ أثناء تسجيل الدخول، يرجى المحاولة لاحقاً.';
          MyServices.displayError(message, context);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        String message = 'حدث خطأ ما، يرجى المحاولة لاحقاً.';
        if (e.code == 'network-request-failed') {
          message = 'لا يوجد اتصال بالانترنت، يرجى التأكد والمحاولة لاحقاً.';
        }
        MyServices.displayError(message, context);
      },
      codeSent: (String verificationId, int resendToken) {
        _verificationCode = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationCode = verificationId;
        notifyListeners();
      },
      timeout: Duration(
        seconds: 90,
      ),
    );
  }
}
