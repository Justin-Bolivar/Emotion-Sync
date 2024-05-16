import 'package:emotion_sync/homepage.dart';
import 'package:emotion_sync/loginpage.dart';
import 'package:emotion_sync/registerpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage() //HomePage(),LoginPage(),RegisterPage()
        );
  }
}
