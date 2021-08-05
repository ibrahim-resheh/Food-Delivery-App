import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food_item.dart';
import 'package:food_delivery_app/widgets/food_item_details_page_footer.dart';
import 'package:food_delivery_app/widgets/food_item_over_view.dart';

import '../constants.dart';

class FoodItemDetailsPage extends StatelessWidget {
  static const routeName = '/food_item_details_page';

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final FoodItem foodItem = data['foodItem'];
    return Scaffold(
      appBar: AppBar(
        title: Text('توصيل'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: FoodItemOverView(foodItem: foodItem),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'المكّونات:',
                    style: kTitleTextStyle,
                  ),
                  Text(
                    foodItem.ingredients,
                    style: kTextStyle.copyWith(fontWeight: FontWeight.normal),
                  ),
                  Spacer(),
                  Expanded(child: FoodItemDetailsPageFooter(foodItem: foodItem,)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
