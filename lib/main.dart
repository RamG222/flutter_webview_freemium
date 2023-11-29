import './firebase_notification_api/firebase_notifications_api.dart';
import './firebase_options.dart';
import './homepage.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //initialize firebase for push notifications
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
    // initializing push notifications service (ask for permissions)
    setupPushNotifications();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Theme data can be used to change whole app coloring scheme,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(88, 111, 124, 100)),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(174, 209, 230, 100)),
        useMaterial3: true,
      ),

      //splash screen
      home: EasySplashScreen(
        navigator: const Homepage(),
        logoWidth: 200,
        logo: Image.asset('assets/splash.png'),
        showLoader: false,
        durationInSeconds: 4,
        loadingText: const Text(
          "Made by Ram Gupta!",
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }
}
