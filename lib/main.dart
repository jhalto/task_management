import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/bottom_nav_bar.dart';
import 'package:task_management/screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check login status
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');

  // Decide the initial screen based on the login status
  Widget initialScreen = (token != null) ? const BottomNavBar() : const Login();

  // Run the app
  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget? initialScreen;

  const MyApp({Key? key, this.initialScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Provide a default fallback widget to avoid errors in tests
      home: initialScreen ?? const Login(),
    );
  }
}
