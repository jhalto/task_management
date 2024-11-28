import 'package:flutter/material.dart';
import 'package:task_management/widgets/custom_colors.dart';
import 'package:task_management/widgets/custom_widgets.dart';
class customTextFromField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  FormFieldValidator? validator;
  TextInputType? inputType;
  Decoration? decoration;
  Icon? icon;
  String? lebel;
customTextFromField({
  super.key,required this.hintText,this.lebel,required this.controller, this.validator, this.inputType,this.decoration,this.icon
});

@override
Widget build(BuildContext context) {
  return TextFormField(

    keyboardType: inputType,
    controller: controller,
    validator: validator,

    textInputAction:  TextInputAction.next,
    decoration: InputDecoration(
      labelText: lebel,
      prefixIcon: icon,
        filled: true,
      fillColor: fieldColor,
      hintText: hintText,
      hintStyle: hintTextStyle(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),

      enabledBorder: OutlineInputBorder(

        borderSide: BorderSide(

          width: 3,
          color: fieldColor,

        ),

        borderRadius: BorderRadius.circular(5),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.5,
          color: nil,

        ),
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}
}