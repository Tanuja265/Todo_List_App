import 'package:flutter/material.dart';
import 'package:todo_list_app/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo List',
      theme: ThemeData(
        
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(34, 156, 255, 1)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        
      ),
      home: const Homepage(),
    );
  }
}


