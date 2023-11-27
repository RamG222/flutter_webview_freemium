import 'package:asdf/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late WebViewController webViewController;
  bool netState = false;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () => _goBack(context),
        child: Scaffold(
            body: Stack(
          children: [
            WebView(
              gestureNavigationEnabled: false,
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              backgroundColor: Colors.white,
              onWebViewCreated: (WebViewController webViewController) {
                this.webViewController = webViewController;
              },
            ),
          ],
        )),
      ),
    );
  }

//Exit app dialog
  Future<bool> _goBack(BuildContext context) async {
    if (await webViewController.canGoBack()) {
      webViewController.goBack();
      return Future.value(false);
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Do you want to Exit?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('NO', style: TextStyle(color: Colors.blue)),
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child:
                        const Text('YES', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ));
      return Future.value(true);
    }
  }
}
