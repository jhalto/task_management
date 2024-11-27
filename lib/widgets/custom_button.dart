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
    return MaterialButton(
      child: Text('$text',style: TextStyle(color: sada,fontWeight: FontWeight.bold),),
       height: 45,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      color: nil,
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
class whiteButton extends StatelessWidget {
  Widget widget;
  VoidCallback? onPressed;
  whiteButton({required this.onPressed,required this.widget});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialButton(
      child: widget,
      height: 45,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
      ),
      color: fieldColor,
      onPressed: onPressed,


    );
  }
}