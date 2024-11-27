import 'package:flutter/material.dart';
import 'package:task_management/widgets/custom_colors.dart';
import 'package:task_management/widgets/custom_widgets.dart';
class customTextFromField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  FormFieldValidator? validator;
  TextInputType? inputType;
  Decoration? decoration;
customTextFromField({
  super.key,required this.hintText,required this.controller, this.validator, this.inputType,this.decoration
});

@override
Widget build(BuildContext context) {
  return TextFormField(

    keyboardType: inputType,
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
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
          width: 3,
          color: fieldColor,

        ),
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}
}