import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_management/pages/home.dart';
import 'package:task_management/pages/profile.dart';
import 'package:task_management/pages/add_task.dart';

import 'widgets/custom_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> pages = [
    Home(),
    AddTask(),
    Profile(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: ConvexAppBar(
          initialActiveIndex: currentIndex,
          style: TabStyle.fixed,
          backgroundColor: nil,
          activeColor: Colors.white,

          items: [
            TabItem(icon: Icons.task, title: 'Task'),
            TabItem(
              icon: CircleAvatar(
                child: Container(
                  child: Icon(
                    Icons.add,
                    color: nil,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 3, color: nil)
                  ),
                ),
                backgroundColor: fieldColor,
              ),
              title: 'Add Task',
            ),
            TabItem(icon: Icons.person, title: 'Profile',),
          ],
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ));
  }
}
