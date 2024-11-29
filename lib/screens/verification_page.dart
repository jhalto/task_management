import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:task_management/api_key/base_url.dart';
import 'package:task_management/widgets/custom_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_from_field.dart';
import '../widgets/custom_widgets.dart';
import 'login.dart';


class VerificationPage extends StatefulWidget {

  VerificationPage({super.key, required this.email});
  String email;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController _otpController = TextEditingController();
  @override


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
         progressIndicator: spinkit,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(

            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(300,130),bottomRight: Radius.elliptical(300,130)),
                  image: DecorationImage(
                    image: AssetImage('lib/images/bd_calling.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(


                  children: [
                    SizedBox(height: 180,),
                    Padding(
                      padding: const EdgeInsets.only(left: 90,right: 90),
                      child: Container(

                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: fieldColor
                        ),
                        child: Center(
                          child: Text(
                            'Verify OTP',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),

                    customTextFromField(hintText: "Enter your otp", controller: _otpController),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){

                      }, child: Text("Resend Otp",style: myStyle(16,FontWeight.bold),)),
                    ),
                    SizedBox(height: 50,),
                    customButton(text: "Submit", onPressed: () {
                      verifyEmail();
                    },)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  var isLoading = false;
  verifyEmail() async {
    try {
      setState(() {
        isLoading = true;
      });
      String email = widget.email.toLowerCase();
      String code = _otpController.text.trim();
      String url = "${baseUrl}/user/activate-user";

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      Map<String, dynamic> body = {
        "email": email,
        "code": code,
      };
      var response = await http.post(Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      var data = jsonDecode(response.body);
      print("Response status: ${response.statusCode}");
      print("Response body: $data");
      if (response.statusCode == 200) {
        showToastMessage("Account Activated Successfully");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      } else {
      showToastMessage("Activation failed");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Something went wrong: $e");
      showToastMessage("${e}");

    }
  }


}