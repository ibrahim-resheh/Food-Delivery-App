import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/my_categories_provider.dart';
import 'package:food_delivery_app/widgets/categories_grid_view.dart';
import 'package:food_delivery_app/widgets/most_requested_list_view.dart';
import 'package:food_delivery_app/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: Provider.of<MyCategoriesProvider>(context, listen: false).fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.teal,
            ),
          );
        } else {
          if (snapshot.error != null) {
            return MyErrorWidget();
          } else {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'الأكثر طلباً:',
                      style: kTitleTextStyle,
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.32,
                    width: screenWidth,
                    child: MostRequestedListView(),
                  ),
                  Container(
                    child: Text(
                      'التصنيفات:',
                      style: kTitleTextStyle,
                    ),
                  ),
                  Expanded(
                    child: CategoriesGridView(),
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}