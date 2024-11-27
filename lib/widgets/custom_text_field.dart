import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  String hintText;
  TextEditingController controller;

  TextInputType? inputType;
  Decoration? decoration;


  customTextField({
    super.key,required this.hintText,required this.controller, this.inputType,this.decoration
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      controller: controller,

      decoration: InputDecoration(

        hintText: hintText,

        enabledBorder: OutlineInputBorder(

          borderSide: BorderSide(
              width: 3,
              color: Colors.black12
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        border: OutlineInputBorder(
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: Colors.blueAccent,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}