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
import 'package:task_management/custom_http/custum_http_request.dart';
import '../bottom_nav_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_colors.dart';
import '../widgets/custom_text_from_field.dart';
import '../widgets/custom_widgets.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key, required this.firstName,required this.lastName ,required this.address, required this.image});
  String? firstName;
  String? lastName;
  String? image;
  String? address;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  TextEditingController? _addressController;
  String? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _addressController = TextEditingController(text: widget.address);
    image = widget.image;
  }
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
        child: widget.address!=null?Scaffold(
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
                                'Edit Profile',
                                style: myStyle(24, FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),



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
                                          : NetworkImage("${baseUrl}/${image}"),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -8,
                                    right: 10,
                                    child: IconButton(onPressed: (){
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
                                        icon: Icon(Icons.photo_camera)
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
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
                                    controller: _firstNameController!,
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
                                    controller: _lastNameController!,
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

                            SizedBox(
                              height: 15,
                            ),

                            customTextFromField(
                              icon: Icon(Icons.maps_home_work_outlined,size: 18,),
                              hintText: "Address",
                              controller: _addressController!,
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            SizedBox(
                              height: 15,
                            ),

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
                              updateProfile();
                            }
                          },
                          text: "Update",
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
        ):spinkit,
      ),
    );
  }

  var isloading = false;

  updateProfile() async {
    try {
      setState(() {
        isloading = true;
      });

      String url = "${baseUrl}/user/update-profile";
      var request = http.MultipartRequest("PATCH", Uri.parse(url));
      request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
      request.fields['firstName'] = _firstNameController!.text.trim();
      request.fields['lastName'] = _lastNameController!.text.trim();
      request.fields['address'] = _addressController!.text.trim();

      if (picked != null) {
        // Use picked image file
        var img = await http.MultipartFile.fromPath(
          "file",
          picked!.path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(img);
      } else if (image != null && image!.isNotEmpty) {
        // Download image from URL, save it temporarily, and attach it
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/temp_image.jpg');

        var response = await http.get(Uri.parse("${baseUrl}/${image}"));
        await tempFile.writeAsBytes(response.bodyBytes);

        var img = await http.MultipartFile.fromPath(
          "file",
          tempFile.path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(img);
      }

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var data = jsonDecode(responseString);
      print("our response is $data");
      print("Response code ${response.statusCode}");

      if (response.statusCode == 200) {
        showToastMessage("Update Successful");
        Navigator.pop(context, true);
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
  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

}
