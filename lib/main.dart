import 'dart:developer';

import 'package:flutter/material.dart';

import 'homepage.dart';

void main() {
  runApp(const MyApp());
  print("sss");
  log("ssss");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:Homepage()
    );
  }
}

