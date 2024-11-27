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