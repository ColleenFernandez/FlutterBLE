import 'package:fble/Page/MainPage.dart';
import 'package:fble/Temp/TempPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage() // TempPage(),
    );
  }
}