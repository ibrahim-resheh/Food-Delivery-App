import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final focusNode;
  final text;
  final Function validateInput;
  final Function saveInput;
  final keyboardType;
  final ctx;
  final IconData icon;

  CustomTextFormField({
    @required this.text,
    @required this.focusNode,
    @required this.validateInput,
    @required this.saveInput,
    @required this.ctx,
    @required this.icon,
    this.keyboardType,
  });

  OutlineInputBorder _buildBorder(Color color){
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        height: 1,
        fontSize: 16,
        color: Colors.teal,
      ),
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validateInput,
      onSaved: saveInput,
      onEditingComplete: () => FocusScope.of(ctx).nextFocus(),
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(icon, color: Colors.white,),
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        errorStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        enabledBorder: _buildBorder(Colors.white),
        errorBorder:  _buildBorder(Colors.teal),
        focusedErrorBorder:  _buildBorder(Colors.teal),
        focusedBorder:  _buildBorder(Colors.teal),
      ),
    );
  }
}
