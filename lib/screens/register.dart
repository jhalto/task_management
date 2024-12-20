import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
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
                              child: Stack(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      radius: 80,
                                      backgroundImage: picked != null
                                          ? FileImage(picked!)
                                          : AssetImage("lib/images/user.png"),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: -8,
                                      right: 10,
                                      child: IconButton( onPressed: () {
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
                                          icon: Icon(Icons.photo_camera,)
                                      )
                                  )
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
                                    inputType: TextInputType.name,
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
                                    inputType: TextInputType.name,
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
                              inputType: TextInputType.streetAddress,
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
                                return null;
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
                                return null;

                                // Return null if the password is valid, otherwise return the error message
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              onEditingComplete: (){
                                if (_formKey.currentState!.validate()) {
                                  getRegister();

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
                                  return null;
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
                              getRegister();
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

  Future<void> getRegister() async {
    try {
      setState(() {
        isloading = true;
      });

      String url = "${baseUrl}/user/register";
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.fields['firstName'] = _firstNameController.text.trim();
      request.fields['lastName'] = _lastNameController.text.trim();
      request.fields['email'] = _emailController.text.trim();
      request.fields['password'] = _passwordController.text.trim();
      request.fields['address'] = _addressController.text.trim();

      // Add file
      if (picked != null) {
        var img = await http.MultipartFile.fromPath(
          "file",
          picked!.path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(img);
      } else {
        File defaultImage = await getImageFileFromAssets('lib/images/user.png');
        var img = await http.MultipartFile.fromPath(
          "file",
          defaultImage.path,
          contentType: MediaType('image', 'png'), // Adjust as needed
        );
        request.files.add(img);
      }

      // Send request
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      print("Response Body: $responseString");
      print("Response Code: ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var data = jsonDecode(responseString);

        if (data['status']?.toString().startsWith("Success") ?? false) {
          showToastMessage(
            "Successfully Registered. A verification code has been sent to email. Please Verify",
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationPage(
                email: _emailController.text.trim(),
              ),
            ),
          );
        } else if (data['error']?.toString().startsWith("E11000") ?? false) {
          showToastMessage(
            "Already Registered. A verification code has been sent to email. Please Verify",
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationPage(
                email: _emailController.text.trim(),
              ),
            ),
          );
        }
      } else {
        // Handle unexpected response
        print("Unexpected response: ${response.statusCode}");
        showToastMessage("Server error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      showToastMessage("An error occurred. Please try again later.");
    } finally {
      setState(() {
        isloading = false;
      });
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
