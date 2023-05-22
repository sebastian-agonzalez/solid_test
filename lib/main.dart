import 'package:flutter/material.dart';

import 'package:solid_task_project/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

///base class for the app
class MyApp extends StatelessWidget {
  ///constructor base class for the app
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 20,
          ),
        ),
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
    );
  }
}
