import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food_item.dart';
import 'package:food_delivery_app/pages/food_item_details_page.dart';
import 'package:food_delivery_app/providers/my_cart_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../my_services.dart';

class FoodItemWidget extends StatelessWidget {
  final FoodItem foodItem;

  FoodItemWidget({
    @required this.foodItem,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final myCartProvider = Provider.of<MyCartProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(FoodItemDetailsPage.routeName, arguments: {
          'foodItem': foodItem,
        });
      },
      child: Container(
        height: screenHeight * 0.3,
        width: screenWidth * 0.7,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
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
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  foodItem.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                title: Text(
                  foodItem.title,
                  style: kTextStyle,
                ),
                subtitle: Text(
                  '${foodItem.price.toString()} ل.س',
                  style: kPriceTextStyle,
                ),
                trailing: IconButton(
                  onPressed: () {
                    myCartProvider.addItem(
                      foodItem.id,
                      foodItem.title,
                      foodItem.price,
                      foodItem.imageUrl,
                    );
                    MyServices.displaySnackBar(context, 'تم إضافة هذا العنصر إلى السلة.');
                  },
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
