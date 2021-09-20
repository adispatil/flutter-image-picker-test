import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strive_benifits_assignment/app/bindings/controller_bindings.dart';

import 'app/screens/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Strive Benefits',
      initialBinding: ControllerBindings(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}