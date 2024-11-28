import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/widgets/custom_button.dart';

myStyle([double? size,FontWeight? fw]){
  return GoogleFonts.roboto(
    fontSize: size,
    fontWeight: fw,
  );
}
styleTextButton(){
  return GoogleFonts.roboto(

    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );
}
hintTextStyle(){
  return TextStyle(
    color: Colors.black26
  );
}
var spinkit = SpinKitSpinningLines(
  color: Colors.red,
);

showToastMessage (String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
titleBold(){
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
  );
}
headingBold(){
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}
subHeadingBold(){
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}
buttonRegular(){
  return TextStyle(
    fontSize: 15,
  );
}
bodyLight(){
  return TextStyle(
      fontSize: 14,
      color: Colors.white
  );
}
bodyBold(){
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
}
tagsRegular(){
  return TextStyle(
      fontSize: 12
  );
}
small(){
  return TextStyle(
    fontSize: 10,
  );
}

