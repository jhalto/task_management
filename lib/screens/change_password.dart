import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http_parser/http_parser.dart';


import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';

import 'package:task_management/api_key/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/bottom_nav_bar.dart';
import 'package:task_management/custom_http/custum_http_request.dart';
import 'package:task_management/widgets/custom_button.dart';

import '../widgets/custom_colors.dart';
import '../widgets/custom_text_from_field.dart';
import '../widgets/custom_widgets.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key,});


  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  bool isObsecure = true;





  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      progressIndicator: spinkit,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onEditingComplete: (){
                      if(_formKey.currentState!.validate()){

                       updatePassword();
                      }
                    },
                    decoration: InputDecoration(
                        hintStyle: hintTextStyle(),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password_outlined,size: 18,),
                        filled: true,
                        fillColor: fieldColor,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: fieldColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.5,
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObsecure = !isObsecure;
                              });
                            },
                            icon: isObsecure == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off))),
                    controller: _passwordController,
                    obscureText: isObsecure,
                    validator: (value) {
                      // Reset error message

                      if (value == null || value.isEmpty) {
                        return 'Password is required.';
                      }

                      // Password length greater than 6
                      if (value.length < 6) {
                        return '• Password must be longer than 6 characters.\n';
                      }
                      // Contains at least one uppercase letter
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        return '• Uppercase letter is missing.\n';
                      }
                      // Contains at least one lowercase letter
                      if (!value.contains(RegExp(r'[a-z]'))) {
                        return '• Lowercase letter is missing.\n';
                      }
                      // Contains at least one digit
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return '• Digit is missing.\n';
                      }
                      // Contains at least one special character
                      if (!value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
                        return '• Special character is missing.\n';
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  customButton(text: "Update", onPressed: (){

                    if(_formKey.currentState!.validate()){

                      updatePassword();
                    }
                  })
                ],
              ),
            ),
          ),
        )

      )
    );
  }

  var isloading = false;

  updatePassword() async {
    try {
      setState(() {
        isloading = true;
      });

      String url = "${baseUrl}/user/update-profile";
      var request = http.MultipartRequest("PATCH", Uri.parse(url));
      request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
      request.fields['password'] = _passwordController.text.trim();




      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var data = jsonDecode(responseString);
      print("our response is $data");
      print("Response code ${response.statusCode}");

      if (response.statusCode == 200) {
        showToastMessage("Update Successful");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));
      } else {
        showToastMessage("Update Not Successful");
      }

      setState(() {
        isloading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isloading = false;
      });
    }
  }

}
