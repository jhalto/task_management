import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:task_management/api_key/base_url.dart';
import 'package:task_management/custom_http/custum_http_request.dart';
import 'package:task_management/screens/drawer_design.dart';

import 'package:task_management/screens/view_task.dart';

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
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }

      String url = "${baseUrl}/task/get-all-task";
      var response = await http.get(
        Uri.parse(url),
        headers: await CustomHttpRequest.getHeaderWithToken(),
      );
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            tasklist = data['data']['myTasks'];
          });
        }
      } else {
        if (mounted) {
          showToastMessage("Failed to load tasks");
        }
      }
    } catch (e) {
      if (mounted) {
        print("Error fetching tasks: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: caya,
      controller: _advancedDrawerController,
      drawer: DrawerDesign(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Task"),
          backgroundColor: nil,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: _advancedDrawerController.showDrawer,
          ),
        ),
        body: tasklist.isEmpty
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
                onTap: () async{
                 var refresh = await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewTask(id: task['_id'].toString())));
                 if(refresh == true){
                   getAllTask();
                 }
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
