import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/my_cart_provider.dart';
import 'package:food_delivery_app/widgets/cart_widgets/cart_item_header.dart';
import 'package:food_delivery_app/widgets/cart_widgets/cart_item_widget.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart_page';

  @override
  Widget build(BuildContext context) {
    final myCartProvider = Provider.of<MyCartProvider>(context);
    final myCart = myCartProvider.myCart;
    return GestureDetector(
      onTap: () {
        //to dismiss on screenKeyboard when tab outside of textField
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            CartItemHeader(myCartProvider: myCartProvider),
            if(myCart.isNotEmpty)
              Text(
                'اسحب لإزالة العنصر من السلة',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: myCartProvider.itemCount,
                itemBuilder: (ctx, index) {
                  return CartItemWidget(
                    id: myCart.values.toList()[index].id,
                    foodItemId: myCart.keys.toList()[index],
                    title: myCart.values.toList()[index].title,
                    price: myCart.values.toList()[index].price,
                    quantity: myCart.values.toList()[index].quantity,
                    imageUrl: myCart.values.toList()[index].imageUrl,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}