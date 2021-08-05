import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/food_items_page.dart';
import 'package:food_delivery_app/providers/my_categories_provider.dart';
import '../constants.dart';
import 'package:provider/provider.dart';


class CategoriesGridView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final myCategoriesProvider = Provider.of<MyCategoriesProvider>(context, listen: false);
    final fetchedCategories = myCategoriesProvider.myCategories;
    return GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: fetchedCategories.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(FoodItemsPage.routeName, arguments: {
                'categoryId': fetchedCategories[index].id,
              });
            },
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.network(fetchedCategories[index].imageUrl, fit: BoxFit.cover,),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(fetchedCategories[index].name, style: kTextStyle),
                    ),
                  ],
                ),
              ),
          );
        });
  }
}
