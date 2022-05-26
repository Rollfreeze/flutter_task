import 'package:flutter/material.dart';
import 'package:flutter_test_app/screens/MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elki FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
			home: const MainScreen(),
    );
  }
}