import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/screens/register.dart';
import 'package:task_management/widgets/custom_button.dart';
import 'package:task_management/widgets/custom_colors.dart';
import 'package:task_management/widgets/custom_text_from_field.dart';

import '../api_key/base_url.dart';
import '../bottom_nav_bar.dart';
import '../widgets/custom_widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObsecure = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    islogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: spinkit,
        opacity: .5,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Stack(
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
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SizedBox(height: 165,),
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
                                  'Log In',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Align(
                              alignment: Alignment.center,
                              child: Text("Welcome to BdCalling",style: myStyle(22,FontWeight.bold),)),
                          SizedBox(height: 15),

                          SizedBox(height: 10),

                          SizedBox(height: 5,),
                          customTextFromField(
                            icon: Icon(Icons.email_outlined,size: 18,),
                              hintText: "Email",
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  return "email can't be null";
                                }
                                if (value.length < 5) {
                                  return "Invalid email";
                                }
                                if (!value.contains("@")) {
                                  return "Invalid email";
                                }
                              },
                          ),
                          
                          SizedBox(height: 15),

                          TextFormField(
                            onEditingComplete: (){
                              if(_formKey.currentState!.validate()){
                                // getLogin();

                              }
                            },
                            decoration: InputDecoration(
                                hintStyle: hintTextStyle(),
                                hintText: "Password",
                                prefixIcon: Icon(Icons.password_outlined),
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
                            controller: passwordController,
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(onPressed: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordResetScreen(),));
                            }, child: Text("Forgot Password",style: myStyle(15,FontWeight.bold),)),
                          ),
                          SizedBox(height: 10,),
                          customButton(text: "Log In", onPressed: (){
                            if(_formKey.currentState!.validate()){
                              getLogin();

                            }
                          }),

                          SizedBox(height: 15,),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                              },

                              child: RichText(
                                text: TextSpan(
                                   style: TextStyle(color: Colors.black54),
                                    text: "Don't have an account yet?",

                                    children: [
                                      TextSpan(
                                        style: TextStyle(color: nil),
                                          text: "Sign up",
                                      ),
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }

  var isLoading = false;
  islogin()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    if(token!= null){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBar(),), (route) => false,);
    }
  }
  Future<void> getLogin() async {
    try {
      setState(() {
        isLoading = true;
      });

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      String url = "$baseUrl/user/login";

      Map<String, dynamic> body = {
        "email": email, // Ensure these keys match the API requirements
        "password": password,
      };

      Map<String, String> headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json",
      };

      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      var data = jsonDecode(response.body);

      print("Response status: ${response.statusCode}");
      print("Response body: ${data}");

      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("token", data['data']['token']);
        print(sharedPreferences.getString("token"));
        showToastMessage("Login Successful");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()),);
      } else {


      }
    } catch (e) {
      print("Something went wrong $e");
      showToastMessage("An error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
