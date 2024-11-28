import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/screens/login.dart';
import 'package:task_management/widgets/custom_button.dart';
import 'package:task_management/widgets/custom_colors.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../widgets/custom_widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdvancedDrawer(
        backdropColor: caya,

          child: Center(child: Text("Hello")), drawer: Drawer(

        backgroundColor: maya.withOpacity(.2),
         child: Column(
           children: [
             DrawerHeader(child: UserAccountsDrawerHeader(accountName: Text("Name"), accountEmail: Text("NAdkflkdss"))),
             customButton(text: "Log out", onPressed: ()async{

               SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
               sharedPreferences.remove("token");
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false,);
             })
           ],
         ),

      )

      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // Position the shadow below the AppBar
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 70,
            elevation: 0,
            // Set elevation to 0 to prevent AppBar shadow
            title: Container(

              child: Column(
                children: [
                  Text(
                    "BdCalling",
                    style:
                    TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Digital Service Provider", style: small()),
                  ),
                ],
              ),
            ),
           
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(Icons.messenger_outline),
              ),
            ],
            centerTitle: true,
          ),
        ),
      ),

    );
  }
}
