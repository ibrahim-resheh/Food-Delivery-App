import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food_item.dart';
import 'package:food_delivery_app/providers/my_cart_provider.dart';
import 'package:food_delivery_app/providers/my_categories_provider.dart';
import 'package:food_delivery_app/widgets/food_item_widget.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../my_services.dart';

class MostRequestedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myCartProvider = Provider.of<MyCartProvider>(context, listen: false);
    final myCategoriesProvider =
        Provider.of<MyCategoriesProvider>(context, listen: false);
    final List<FoodItem> mostRequestedList =
        myCategoriesProvider.mostRequestedFoodItems();
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: mostRequestedList.length,
      itemBuilder: (ctx, index) {
        return FoodItemWidget(foodItem: mostRequestedList[index]);
      },
    );
  }
}
