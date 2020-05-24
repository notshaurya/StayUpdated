import 'package:flutter/material.dart';
import 'package:NEW_APP/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StayUpdated',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Circular',
      ),
      home: Homepage(),
    );
  }
}