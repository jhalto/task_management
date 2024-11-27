import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/api_key/base_url.dart';
import 'package:http/http.dart'as http;
import 'package:task_management/screens/verification_page.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_colors.dart';
import '../widgets/custom_text_from_field.dart';
import '../widgets/custom_widgets.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _firstNameContoller = TextEditingController();
  TextEditingController _lastNameContoller = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _phoneContoller = TextEditingController();
  TextEditingController _passwordContoller = TextEditingController();
  TextEditingController _confirmPasswordContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObsecure1 = true;
  bool isObsecure2 = true;
  String phone = '';
  String? photo;
  File? picked;

  pickImageFromCamera()async{
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if(pickedImage!= null){
      setState(() {
        picked = File(pickedImage.path);
      });
    }
  }
  pickImageFromGallary()async{
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage!= null){
      setState(() {
        picked = File(pickedImage.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      progressIndicator: spinkit,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 165,),
                        Padding(
                          padding: const EdgeInsets.only(left: 90,right: 90),
                          child: Container(

                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: nil,
                            ),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: myStyle(24,FontWeight.bold),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 15),
                        Text("Welcome to Bdcalling",style: myStyle(22,FontWeight.bold)),
                        SizedBox(height: 5,),
                        Text("Please enter your details below to get started",style: myStyle(15,FontWeight.bold)),
                        SizedBox(height: 25,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Center(
                              child: CircleAvatar(

                                radius: 100,
                                backgroundImage: picked!= null?FileImage(picked!):AssetImage("lib/images/user.png"),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Align(
                              alignment: Alignment.center,
                              child: addButton(text: "Add Image",
                                  onPressed: (){
                                    showModalBottomSheet(context: context, builder: (context) {
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,

                                          children: [

                                          ],
                                        ),
                                      );

                                    },);
                                  }
                              ),
                            ),
                            Text("Name",style: myStyle(18,FontWeight.bold),),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Expanded(child: customTextFromField(
                                  hintText: "First Name",
                                  controller: _firstNameContoller,
                                  validator: (value) {
                                    if (value!.isEmpty || value == null) {
                                      return "name can't be empty";
                                    }
                                    if (value.length < 3) {
                                      return "must at least 3 letter";
                                    }
                                    return null;
                                  },
                                ),
                                ),
                                SizedBox(width: 5,),
                                Expanded(child: customTextFromField(
                                  hintText: "Last Name",
                                  controller: _lastNameContoller,
                                  validator: (value) {
                                    if (value!.isEmpty || value == null) {
                                      return "name can't be empty";
                                    }
                                    if (value.length < 3) {
                                      return "must at least 3 letter";
                                    }
                                    return null;
                                  },
                                ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Text("Email",style: myStyle(18,FontWeight.bold),),
                            SizedBox(height: 5,),
                            customTextFromField(
                              hintText: "Enter your email",
                              controller: _emailContoller,
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
                            SizedBox(
                              height: 5,
                            ),
                            Text("Phone",style: myStyle(18,FontWeight.bold),),
                            SizedBox(height: 5,),

                            IntlPhoneField(
                              onChanged: (value) {
                                setState(() {
                                  phone = value.completeNumber;
                                });

                              },
                              initialCountryCode: 'BD',
                              decoration: InputDecoration(
                                hintText: "Enter Your Phone",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 3, color: Colors.black12),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.blueAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            IconButton(onPressed: (){
                              pickImageFromCamera();
                            }, icon: Icon(Icons.photo)),
                            Text("Password",style: myStyle(18,FontWeight.bold),),
                            SizedBox(height: 5,),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.5, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2.5,
                                      color: Colors.blueAccent,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isObsecure1 = !isObsecure1;
                                        });
                                      },
                                      icon: isObsecure1 == true
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off))),
                              controller: _passwordContoller,
                              obscureText: isObsecure1,
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

                                // Return null if the password is valid, otherwise return the error message
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Confirm Password",style: myStyle(18,FontWeight.bold),),
                            SizedBox(height: 5,),
                            TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Enter your password",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.5, color: Colors.black12),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2.5,
                                        color: Colors.blueAccent,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isObsecure2 = !isObsecure2;
                                          });
                                        },
                                        icon: isObsecure2 == true
                                            ? Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off))),
                                controller: _confirmPasswordContoller,
                                obscureText: isObsecure2,
                                onChanged: (value) {
                                  value = value;
                                },
                                validator: (value) {

                                  // Reset error message
                                  if(_passwordContoller.text.toString() != _confirmPasswordContoller.text.toString()){
                                    return "Password doesn't match";
                                  }
                                }
                            ),
                            SizedBox(
                              height: 5,
                            ),

                          ],),
                        SizedBox(height: 25,),
                        customButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {

                              showToastMessage("succesfull");
                            }
                          },
                          text: "Sign Up",
                        ),


                        SizedBox(height: 300,)
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  var isloading = false;

  // getregister() async {
  //   try {
  //     setState(() {
  //       isloading = true;
  //     });
  //
  //     print("Email before sending: ${_emailContoller.text.toString()}");
  //     String url = "${baseUrl}/user/register";
  //     var request = http.MultipartRequest("POST", Uri.parse(url));
  //     request.fields['first']
  //     var map = <String, dynamic>{};
  //     map["name"] = _nameContoller.text.toString();
  //     map['email'] = _emailContoller.text.toString();
  //     map['phone'] = phone.toString();
  //     map['password'] = _passwordContoller.text.toString();
  //     if(picked!= null){
  //       var img = await http.MultipartFile.fromPath("photo", picked!.path);
  //       request.files.add(img);
  //     }else{
  //
  //     }
  //
  //     var response = await http.post(Uri.parse(url), body: map);
  //     var data = jsonDecode(response.body);
  //
  //     print("Request Payload: ${jsonEncode(map)}");
  //     print(response.statusCode);
  //     print(data);
  //     setState(() {
  //       isloading = false;
  //     });
  //     if (response.statusCode == 200) {
  //       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //       sharedPreferences.setString('email', _emailContoller.text.toString());
  //
  //       String email = _emailContoller.text.toString();
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => VerificationPage(
  //             ),
  //           )).then(
  //             (value) {
  //           setState(() {
  //             _nameContoller.clear();
  //             _emailContoller.clear();
  //             _phoneContoller.clear();
  //             _passwordContoller.clear();
  //           });
  //         },
  //       );
  //     }
  //
  //     setState(() {
  //       isloading = false;
  //     });
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }


}
