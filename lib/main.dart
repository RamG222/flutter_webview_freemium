import 'package:asdf/homepage.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
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
      home: EasySplashScreen(
        navigator: const Homepage(),
        logoWidth: 300,
        logo: Image.asset('assets/splash.png'),
        durationInSeconds: 4,
        loadingText: const Text(
          "Made by Ram Gupta!",
          style: TextStyle(color: Colors.blueGrey),
        ),
        loaderColor: Colors.blue,
        showLoader: true,
      ),
    );
  }
}
