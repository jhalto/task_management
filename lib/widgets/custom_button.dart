import 'package:flutter/material.dart';

import 'custom_colors.dart';
import 'custom_widgets.dart';

class customButton extends StatelessWidget {
  String? text;
  VoidCallback? onPressed;
  customButton({required this.text,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      child: Text('$text',style: myStyle(18),),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: onPressed,


    );
  }
}
class addButton extends StatelessWidget {
  String? text;
  VoidCallback? onPressed;
  addButton({required this.text,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialButton(
      child: Text('$text',style: styleTextButton(),),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      onPressed: onPressed,
       color: nil,

    );
  }
}