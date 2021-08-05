import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/my_cart_provider.dart';
import 'package:food_delivery_app/providers/my_orders_provider.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../my_services.dart';


class CartItemHeader extends StatelessWidget {
  final MyCartProvider myCartProvider;
  final TextEditingController _controller = TextEditingController();

  CartItemHeader({
    @required this.myCartProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'المجموع:',
                  style: kTextStyle,
                ),
                SizedBox(
                  width: 10,
                ),
                Chip(
                  backgroundColor: Colors.deepOrangeAccent.shade100,
                  label: Text('${myCartProvider.totalAmount} ل.س',
                      style: kPriceTextStyle),
                ),
                Spacer(),
                OrderButton(
                  myCartProvider: myCartProvider,
                  extraNotesController: _controller,
                ),
              ],
            ),
          ),
        ),
        if (myCartProvider.myCart.isNotEmpty)
          Container(
            margin: const EdgeInsets.all(8),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'ملاحظات إضافية',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}


class OrderButton extends StatefulWidget {
  final MyCartProvider myCartProvider;
  final TextEditingController extraNotesController;

  OrderButton({
    @required this.myCartProvider,
    @required this.extraNotesController,
  });

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  TextEditingController _addressController = TextEditingController();

  void saveOrder(BuildContext context){
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(
              'العنوان:',
              style: kTextStyle,
            ),
            content: TextField(
              controller: _addressController,
              maxLength: 50,
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    await Provider.of<MyOrdersProvider>(
                        context, listen: false)
                        .addOrder(
                      widget.myCartProvider.myCart.values.toList(),
                      widget.myCartProvider.totalAmount,
                      widget.extraNotesController.text,
                      _addressController.text,
                    );
                    widget.myCartProvider.clearCart();
                    MyServices.displaySnackBar(context, 'تم تسجيل طلبك، الوقت المتوقع للوصول من 20 إلى 35 دقيقة.');
                  } catch (e) {
                    MyServices.displaySnackBar(context, 'حدث خطأ ما، الرجاء إعادة المحاولة.');
                  }
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(context).pop();
                },
                child: Text('موافق'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    widget.extraNotesController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.myCartProvider.itemCount == 0
          ? null
          : () {
        saveOrder(context);
      },
      child: _isLoading
          ? CircularProgressIndicator(
        backgroundColor: Colors.teal,
      )
          : Text(
        'تثبيت الطلب',
      ),
    );
  }

}
