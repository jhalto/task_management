import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_colors.dart';
import 'login.dart';

class DrawerDesign extends StatefulWidget {
  const DrawerDesign({super.key});

  @override
  State<DrawerDesign> createState() => _DrawerDesignState();
}

class _DrawerDesignState extends State<DrawerDesign> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: maya.withOpacity(0.8),
      child: Column(
        children: [
          const DrawerHeader(
            child: UserAccountsDrawerHeader(
              accountName: Text("John Doe"),
              accountEmail: Text("johndoe@example.com"),
            ),
          ),
          customButton(
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
        ],
      ),
    );
  }
}
