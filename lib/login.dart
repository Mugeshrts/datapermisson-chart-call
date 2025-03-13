import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tank_monetering/home/homeui.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pushReplacementNamed(context, "/home");
            Get.to(() => HomeScreen());
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}
