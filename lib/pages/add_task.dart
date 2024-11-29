import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:task_management/api_key/base_url.dart';
import 'package:task_management/bottom_nav_bar.dart';
import 'package:task_management/custom_http/custum_http_request.dart';
import 'package:task_management/pages/home.dart';
import 'package:task_management/widgets/custom_button.dart';
import 'package:task_management/widgets/custom_colors.dart';
import 'package:task_management/widgets/custom_widgets.dart';
import 'package:http/http.dart'as http;

import '../screens/drawer_design.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AdvancedDrawer(
        backdropColor: caya,
        controller: _advancedDrawerController,
        drawer: DrawerDesign(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,

          appBar: AppBar(
            title: const Text("All Task"),
            backgroundColor: nil,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: _advancedDrawerController.showDrawer,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title",style: bodyBold(),),
                  Container(
                    child: TextField(
                      controller: titleController,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Description",style: bodyBold(),),
                  SizedBox(height: 20),
                  Container(
                    child: TextField(
                      controller: descriptionController,
                      maxLines: 5,
                    ),
                  ),
                  SizedBox(height: 40,),
                  customButton(text: "Save",
                      onPressed: (){
                       createTask();
                      })

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  var isLoading = false;
  createTask()async{
    try{
      setState(() {
        isLoading = true;
      });
      String url = "${baseUrl}/task/create-task";
      var body = <String,dynamic>{};
      body['title'] = titleController.text.toString();
      body['description']= descriptionController.text.toString();
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(body),
          headers: await CustomHttpRequest.getHeaderWithToken()
      );
      var data = jsonDecode(response.body);
      print(data);
      print(response.statusCode);
      if(response.statusCode == 200){
        showToastMessage("Task Created");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){

    }
  }
}