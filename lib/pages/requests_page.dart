import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/my_orders_provider.dart';
import 'package:food_delivery_app/widgets/my_error_widget.dart';
import 'package:food_delivery_app/widgets/requests_list.dart';
import 'package:provider/provider.dart';

class RequestsPage extends StatelessWidget {
  static const routeName = '/requests_page';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MyOrdersProvider>(context, listen: false).fetchOrders(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.teal,
            ),
          );
        } else{
          if (snapshot.error != null) {
            return MyErrorWidget();
          } else{
            return RequestsList();
          }
        }
      },
    );
  }
}
