import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/requests_page.dart';
import 'package:food_delivery_app/providers/my_firebase_auth_provider.dart';
import 'package:food_delivery_app/widgets/cart_widgets/cart_icon.dart';
import 'package:food_delivery_app/widgets/my_drawer.dart';
import 'package:provider/provider.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TabsPage extends StatefulWidget {
  static const routeName = '/tabs_page';

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  Widget _buildTab(Widget widget, String text) {
    return Tab(
      iconMargin: const EdgeInsets.only(bottom: 4),
      icon: widget,
      text: text,
    );
  }

  Future<void> checkUserInfo() async {
    final myFirebaseAuthProvider =
        Provider.of<MyFirebaseAuthProvider>(context, listen: false);
    if (myFirebaseAuthProvider.name == null) {
      final phoneNumber = FirebaseAuth.instance.currentUser.phoneNumber.substring(4);
      await myFirebaseAuthProvider.fetchUserInfo(phoneNumber);
    }
  }

  @override
  void initState() {
    //if user is already signed in when open the app fetch his info
    Future.delayed(
      Duration(seconds: 3),
    ).then((value) {
      checkUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('توصيل'),
          bottom: TabBar(
            tabs: [
              _buildTab(
                  Icon(
                    Icons.home_outlined,
                    size: 22,
                  ),
                  'الرئيسية'),
              _buildTab(CartIcon(), 'السلة'),
              _buildTab(
                  Icon(
                    Icons.article_outlined,
                    size: 22,
                  ),
                  'طلباتي'),
            ],
          ),
        ),
        drawer: MyDrawer(),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: [
              HomePage(),
              CartPage(),
              RequestsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
