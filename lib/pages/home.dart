import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/api_key/base_url.dart';
import 'package:task_management/custom_http/custum_http_request.dart';
import 'package:task_management/screens/login.dart';
import 'package:task_management/widgets/custom_button.dart';
import 'package:task_management/widgets/custom_colors.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../widgets/custom_widgets.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _advancedDrawerController = AdvancedDrawerController();
  List<dynamic> tasklist = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getAllTask();
  }

  Future<void> getAllTask() async {
    try {
      setState(() {
        isLoading = true;
      });
      String url = "${baseUrl}/task/get-all-task";
      var response = await http.get(
        Uri.parse(url),
        headers: await CustomHttpRequest.getHeaderWithToken(),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          tasklist = data['data']['myTasks'];
        });
      } else {
        showToastMessage("Failed to load tasks");
      }
    } catch (e) {
      print("Error fetching tasks: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: caya,
      controller: _advancedDrawerController,
      drawer: Drawer(
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
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BdCalling"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: _advancedDrawerController.showDrawer,
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : tasklist.isEmpty
            ? const Center(child: Text("No tasks available"))
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: tasklist.length,
            itemBuilder: (context, index) {
              final task = tasklist[index];
              return GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ,))
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          task['description'],
                          style: const TextStyle(fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "ID: ${task['_id']}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
