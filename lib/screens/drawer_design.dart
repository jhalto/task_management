import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/bottom_nav_bar.dart';
import 'package:task_management/screens/change_password.dart';
import 'package:task_management/widgets/custom_widgets.dart';
import '../api_key/base_url.dart';
import '../custom_http/custum_http_request.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_colors.dart';
import 'login.dart';

class DrawerDesign extends StatefulWidget {
  const DrawerDesign({super.key});

  @override
  State<DrawerDesign> createState() => _DrawerDesignState();
}

class _DrawerDesignState extends State<DrawerDesign> {
  String? name;
  String? email;
  String? address;
  String? image;
  String? firstName;
  String? lastName;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      setState(() {
        isLoading = true;
      });

      String url = "${baseUrl}/user/my-profile";
      var response = await http.get(
        Uri.parse(url),
        headers: await CustomHttpRequest.getHeaderWithToken(),
      );

      var data = jsonDecode(response.body);
      print(data);
      print("${response.statusCode}");

      if (response.statusCode == 200) {
        setState(() {
          firstName = data['data']['firstName'];
          lastName = data['data']['lastName'];
          email = data['data']['email'];
          address = data['data']['address'];
          image = data['data']['image'];
          name = "$firstName $lastName";
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: maya.withOpacity(0.9),
      child: isLoading
          ? Center(
        child: spinkit, // Show spinner while loading
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPictureSize: const Size(70, 70),
            margin: const EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(color: nil.withOpacity(.5)),
            accountName: Text(
              name ?? "Loading...", // Fallback while loading
              style: const TextStyle(fontSize: 18),
            ),
            accountEmail: Text(
              email ?? "Loading...", // Fallback while loading
              style: const TextStyle(fontSize: 16),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  NetworkImage("${baseUrl}/${image}"??""),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                    );
                  },
                ),
                ListTile(

                  leading: const Icon(Icons.home, color: Colors.white),
                  title: const Text(
                    "Change Password",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ChangePassword()),
                    );
                  },
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20, bottom:  50),
            child: customButton(
              text: "Log Out",
              onPressed: () async {
                SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
                sharedPreferences.remove("token");
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
