import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/my_cart_provider.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.shopping_cart_outlined,
          //size: 22,
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            //padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.teal,
            ),
            constraints: BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: Consumer<MyCartProvider>(
              builder: (ctx, myCartProvider, ch) => Text(
                myCartProvider.itemCount.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
