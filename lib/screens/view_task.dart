import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:task_management/api_key/base_url.dart';
import 'package:http/http.dart'as http;
import 'package:task_management/bottom_nav_bar.dart';
import 'package:task_management/custom_http/custum_http_request.dart';
import 'package:task_management/widgets/custom_button.dart';
import 'package:task_management/widgets/custom_widgets.dart';

class ViewTask extends StatefulWidget {
  ViewTask({super.key, required this.id});
  String? id;

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  String? id;
  var taskData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    id = widget.id;
    if(id!=null){
      getTask();
    }
  }
  var isLoading = false;
  getTask()async{
    try{
      setState(() {
        isLoading = false;
      });
      String url = "${baseUrl}/task/get-task/${id}";
      var response = await http.get(Uri.parse(url),headers:await CustomHttpRequest.getHeaderWithToken());
      var data = jsonDecode(response.body);
      print(data);
      print(response.statusCode);
      if(response.statusCode == 200){
        taskData = data['data'];
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: spinkit,
      child: taskData!=null?Scaffold(

        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title",style: bodyBold(),),
              SizedBox(height: 15,),
              Text("${taskData['title']}"),
              SizedBox(height: 15,),
              Text("Description",style: bodyBold(),),
              SizedBox(height: 15,),
              Text("${taskData['description']}"),
              SizedBox(height: 50,),
              customButton(text: "Delete",
                  onPressed: (){
                    deleteTask();
                  }
              )
            ],
          ),
        ),
      ):spinkit,
    );
  }
  deleteTask()async{
    try{
      String url = "${baseUrl}/task/delete-task/${id}";
      var response = await http.delete(Uri.parse(url),headers: await CustomHttpRequest.getHeaderWithToken());
      var data = jsonDecode(response.body);
      print(response.statusCode);
      print(data);
      if(response.statusCode == 200){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));
      }
    }catch(e){

    }

  }
}
