import 'package:flutter/material.dart';
import 'package:tugaswidget/nilai.dart';
import 'package:tugaswidget/v_json.dart';
import 'package:tugaswidget/widget3.dart';
import 'widget3.dart';
import 'widget2.dart';
import 'widget1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  ViewJson(),
    );
  }
}
