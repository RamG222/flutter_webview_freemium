import 'package:asdf/firebase_notification_api/firebase_notifications_api.dart';
import 'package:asdf/firebase_options.dart';
import 'package:asdf/homepage.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setupPushNotifications();
    super.initState();
  }

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
