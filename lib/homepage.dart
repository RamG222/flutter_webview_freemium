// ignore_for_file: deprecated_member_use

import 'package:asdf/No_Internet_widget.dart';
import 'package:asdf/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //initialize controller
  late WebViewController webViewController;

  bool netState = false;
  @override
  void initState() {
    super.initState();
    //checking internet connection
    checkInternetConnection();
  }

  //method for Checking internet connection
  Future checkInternetConnection() async {
    final connectionStatus = await (Connectivity().checkConnectivity());
    if (connectionStatus == ConnectivityResult.none) {
      setState(() {
        netState = false;
      });
    } else {
      setState(() {
        netState = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //pop scope for exit dialog
      child: WillPopScope(
        onWillPop: () => _goBack(context),
        child: Scaffold(
          //left drawer
          drawer: Drawer(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset('assets/splash.png'),
                    SizedBox(
                      height: 100,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await launch(shareURL);
                        Navigator.of(context).pop();
                      },
                      child: Text('Share'),
                    ),
                    SizedBox(height: 20)
                  ],
                ),
                FilledButton.tonal(
                    child: Text('Refresh'),
                    onPressed: () {
                      webViewController.reload();
                      Navigator.of(context).pop();
                    }),
                SizedBox(height: 20),
                FilledButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text('Quit')),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: FilledButton.tonal(
                      onPressed: () {
                        Restart.restartApp();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.restart_alt_rounded),
                          Text('Restart whole app')
                        ],
                      )),
                )
              ],
            ),
          ),

          //AppBar
          appBar: AppBar(
            title: const Text(appbarTitle),
          ),
          //Floating refresh button
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                webViewController.reload();
              },
              child: const Icon(Icons.refresh)),
          body: Stack(
            children: [
              //checks for internet connection
              if (netState)
                //main webview widget
                WebView(
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  // you can also remove headers/foots using javascript
                  backgroundColor: Colors.white,
                  onWebViewCreated: (WebViewController webViewController) {
                    this.webViewController = webViewController;
                  },
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.startsWith(url)) {
                      return NavigationDecision.navigate;
                    } else {
                      //launch url in Browser (outside app)
                      _launchURL(request.url);
                      return NavigationDecision.prevent;
                    }
                  },
                )
              else
                //show when no internet connction found
                const NoInternetWidget(),
            ],
          ),
        ),
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

//method for launching external url
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
