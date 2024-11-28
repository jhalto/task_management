import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/api_key/base_url.dart';
import 'package:http/http.dart' as http;
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
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObsecure1 = true;
  bool isObsecure2 = true;
  String phone = '';
  String? photo;
  File? defaultImageFile;
  File? picked;

  pickImageFromCamera() async {
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        picked = File(pickedImage.path);
      });
    }
  }

  pickImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
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
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(300, 130),
                        bottomRight: Radius.elliptical(300, 130)),
                    image: DecorationImage(
                      image: AssetImage('lib/images/bd_calling.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 90, right: 90),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: fieldColor,
                            ),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: myStyle(24, FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text("Welcome to Bdcalling",
                            style: myStyle(22, FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Please enter your details below to get started",
                            style: myStyle(15, FontWeight.bold)),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: picked != null
                                    ? FileImage(picked!)
                                    : AssetImage("lib/images/user.png"),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        builder: (context) {
                                          return Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomRight,
                                                  colors: [
                                                    fieldColor,
                                                    Colors.blue.withOpacity(.3)
                                                  ]),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  whiteButton(
                                                    onPressed: () {
                                                      pickImageFromCamera();
                                                      Navigator.pop(context);
                                                    },
                                                    widget: Row(
                                                      mainAxisAlignment:MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                            Icons.photo_camera),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Text("Camera")
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  whiteButton(
                                                    onPressed: () {
                                                      pickImageFromGallery();
                                                      Navigator.pop(context);
                                                    },
                                                    widget: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.photo_album_outlined),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Text("Gallery")
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.image),
                                        Text(
                                          "Add Image",
                                          style: myStyle(16, FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: customTextFromField(
                                    hintText: "First Name",
                                    icon: Icon(FontAwesomeIcons.user,size: 15,),
                                    controller: _firstNameController,
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
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: customTextFromField(
                                    hintText: "Last Name",
                                    icon: Icon(FontAwesomeIcons.user,size: 15,),
                                    controller: _lastNameController,
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
                              height: 15,
                            ),
                            customTextFromField(
                              
                              icon: Icon(Icons.email_outlined,size: 18,),
                              hintText: "Email",
                              controller: _emailController,
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
                              height: 15,
                            ),

                            customTextFromField(
                              icon: Icon(Icons.maps_home_work_outlined,size: 18,),
                              hintText: "Address",
                              controller: _addressController,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(

                                  prefixIcon: Icon(Icons.password_outlined,size: 18,),
                                  hintStyle: hintTextStyle(),
                                  filled: true,
                                  fillColor: fieldColor,
                                  hintText: "Password",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: fieldColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2.5,
                                      color: nil,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isObsecure1 = !isObsecure1;
                                        });
                                      },
                                      icon: isObsecure1 == true
                                          ? Icon(
                                              Icons.visibility,
                                              color: Colors.black38,
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              color: Colors.black38,
                                            ))),
                              controller: _passwordController,
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
                                if (!value.contains(
                                    RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
                                  return '• Special character is missing.\n';
                                }

                                // Return null if the password is valid, otherwise return the error message
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              onEditingComplete: (){
                                if (_formKey.currentState!.validate()) {
                                  getregister();

                                }
                              },
                                decoration: InputDecoration(

                                    prefixIcon: Icon(Icons.password_outlined,size: 18,),
                                    hintStyle: hintTextStyle(),
                                    fillColor: fieldColor,
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: "Confirm Password",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: fieldColor),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2.5,
                                        color: nil,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isObsecure2 = !isObsecure2;
                                          });
                                        },
                                        icon: isObsecure2 == true
                                            ? Icon(
                                                Icons.visibility,
                                                color: Colors.black38,
                                              )
                                            : Icon(
                                                Icons.visibility_off,
                                                color: Colors.black38,
                                              ))),
                                controller: _confirmPasswordController,
                                obscureText: isObsecure2,
                                onChanged: (value) {
                                  value = value;
                                },
                                validator: (value) {

                                  if (_passwordController.text.toString() !=
                                      _confirmPasswordController.text
                                          .toString()) {
                                    return "Password doesn't match";
                                  }
                                }),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        customButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              getregister();
                              showToastMessage("Successful");
                            }
                          },
                          text: "Sign Up",
                        ),
                        SizedBox(
                          height: 300,
                        )
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

getregister() async {
  try {
    setState(() {
      isloading = true;
    });

    String url = "${baseUrl}/user/register";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.fields['firstName'] = _firstNameController.text.toString();
    request.fields['lastName'] = _lastNameController.text.toString();
    request.fields['email'] = _emailController.text.toString();
    request.fields['password'] = _passwordController.text.toString();
    request.fields['address'] = _addressController.text.toString();

    if (picked != null) {
      var img = await http.MultipartFile.fromPath("file", picked!.path);
      request.files.add(img);
    } else {
      File f = await getImageFileFromAssets('lib/images/user.png');
      var img = await http.MultipartFile.fromPath('file',f.path);
      request.files.add(img);
    }


    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var data = jsonDecode(responseString);
    print("our response is $data");
    print(data.statusCode);


    setState(() {
      isloading = false;
    });
  } catch (e) {
    print("Error: $e");
  }
}
  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

}
