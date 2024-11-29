import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/api_key/base_url.dart';
import 'package:task_management/widgets/custom_button.dart';

import '../screens/edit_profile.dart';
import '../widgets/custom_colors.dart';
import '../widgets/custom_widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  String? name;
  String? email;
  String? address;
  String? image;
  String? firstName;
  String? lastName;
  var isLoading = false;
  getUserData()async{
    try{
      setState(() {
        isLoading = true;
      });
      String url = "${baseUrl}/user/my-profile";

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      var headers =<String,String>{};
      headers['Authorization'] = "Bearer $token";
      headers['Content-Type'] = "application/json; charset=utf-8";
      headers['Accept'] = "application/json";

      var response = await http.get(Uri.parse(url),headers: headers);
      var data = jsonDecode(response.body);

      print(data);
      print("${response.statusCode}");
      if(response.statusCode== 200){
        setState(() {
          firstName = "${data['data']['firstName']}";
          lastName = "${data['data']['lastName']}";
          email = "${data['data']['email']}";
          address = "${data['data']['address']}";
          image = "${data['data']['image']}";
          name = "${data['data']['firstName']} ${data['data']['lastName']}";
        });

      }

    }catch(e){

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: name!=null?Stack(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                      child: Container(
                        color: fieldColor.withOpacity(.8),
                      )
                  ),
                  Expanded(
                    flex: 2,
                      child: Container(
                        color: Colors.black12.withOpacity(.1),
                      )
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage("${baseUrl}/${image}"),
                    ),
                  Text(name!,style: titleBold(),),
                  Text(email!),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.location_solid),
                      SizedBox(width: 5,),
                      Text(address!,style: myStyle(16),),

                    ],
                  ),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: customButton(text: "Edit Profile",
                        onPressed: () async{
                      final updated = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(
                        firstName: firstName.toString(),
                        lastName: lastName.toString(),

                        address: address.toString(),
                      )));
                      if (updated == true) {
                        getUserData(); // Refresh the profile data
                      }
                        }),
                  )
                ],
              ),
            ),

          ],
        ):spinkit
    );
  }
}


