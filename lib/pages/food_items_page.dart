import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/my_category.dart';
import 'package:food_delivery_app/providers/my_categories_provider.dart';
import 'package:food_delivery_app/widgets/food_item_widget.dart';
import 'package:provider/provider.dart';

class FoodItemsPage extends StatelessWidget {
  static const routeName = '/food_items_page';

  @override
  Widget build(BuildContext context) {
    final myCategoriesProvider = Provider.of<MyCategoriesProvider>(context, listen: false);
    final data = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String categoryId= data['categoryId'];
    final MyCategory myCategory = myCategoriesProvider.findCategoryById(categoryId);
    return Scaffold(
      appBar: AppBar(
        title: Text(myCategory.name),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: myCategory.foodItems.length,
        itemBuilder: (ctx, index) {
          return FoodItemWidget(foodItem: myCategory.foodItems[index],);
        },
      ),
    );
  }
}
