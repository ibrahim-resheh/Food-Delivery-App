import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food_delivery_app/pages/cart_page.dart';
import 'package:food_delivery_app/pages/food_item_details_page.dart';
import 'package:food_delivery_app/pages/food_items_page.dart';
import 'package:food_delivery_app/pages/phone_auth/otp_page.dart';
import 'package:food_delivery_app/pages/phone_auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/phone_auth/sign_up_page.dart';
import 'package:food_delivery_app/pages/requests_page.dart';
import 'package:food_delivery_app/pages/tabs_page.dart';
import 'package:food_delivery_app/pages/user_info_page.dart';
import 'package:food_delivery_app/providers/my_cart_provider.dart';
import 'package:food_delivery_app/providers/my_categories_provider.dart';
import 'package:food_delivery_app/providers/my_firebase_auth_provider.dart';
import 'package:food_delivery_app/providers/my_orders_provider.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //set status bar to transparent
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.deepOrangeAccent,
      // //systemNavigationBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyCategoriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyFirebaseAuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyCartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyOrdersProvider(),
        ),
      ],
      child: FoodDeliveryApp(),
    ),
  );
}

class FoodDeliveryApp extends StatelessWidget {
  //initialize firebase
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String userId = '';
          if(FirebaseAuth.instance.currentUser != null){
            userId = FirebaseAuth.instance.currentUser.uid;
          }
          return Directionality(
            textDirection: TextDirection.rtl,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                Locale(
                    'ar', 'AE'), // OR Locale('ar', 'AE') OR Other RTL locales
              ],
              locale: Locale(
                  'ar', 'AE'), // OR Locale('ar', 'AE') OR Other RTL locales,
              theme: ThemeData(
                primaryColor: Colors.deepOrangeAccent,
                accentColor: Colors.white,
                primarySwatch: Colors.teal,
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'Changa',
                appBarTheme: AppBarTheme(
                  brightness: Brightness.dark,
                  centerTitle: true,
                  textTheme: TextTheme(
                    headline6: kAppBarTitleTextStyle,
                  ),
                ),
              ),
              initialRoute: userId == '' ? SignInPage.routeName : TabsPage.routeName,
              routes: {
                TabsPage.routeName: (context) => TabsPage(),
                CartPage.routeName: (context) => CartPage(),
                RequestsPage.routeName: (context) => RequestsPage(),
                FoodItemsPage.routeName: (context) => FoodItemsPage(),
                FoodItemDetailsPage.routeName: (context) => FoodItemDetailsPage(),
                SignInPage.routeName: (context) => SignInPage(),
                SignUpPage.routeName: (context) => SignUpPage(),
                OTPPage.routeName: (context) => OTPPage(),
                UserInfoPage.routeName: (context) => UserInfoPage(),
              },
            ),
          );
        } else {
          if (snapshot.hasError) {
            return MaterialApp(
                home: Scaffold(body: Center(child: Text('Error'))));
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())));
      },
    );
  }
}
