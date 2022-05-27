import 'package:flutter/material.dart';
import 'package:flutter_test_app/components/NavigationService.dart';
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
			navigatorKey: NavigationService.instance.navigationKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
			home: const MainScreen(),
    );
  }
}

