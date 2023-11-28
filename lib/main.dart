import 'package:asdf/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(88, 111, 124, 100)),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(174, 209, 230, 100)),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}
