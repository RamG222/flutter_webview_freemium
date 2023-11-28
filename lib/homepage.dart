import 'package:asdf/No_Internet_widget.dart';
import 'package:asdf/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late WebViewController webViewController;

  bool netState = false;
  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

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
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () => _goBack(context),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter webview appBar'),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  webViewController.reload();
                },
                child: const Icon(Icons.refresh)),
            body: Stack(
              children: [
                if (netState)
                  WebView(
                    initialUrl: url,
                    javascriptMode: JavascriptMode.unrestricted,
                    backgroundColor: Colors.white,
                    onWebViewCreated: (WebViewController webViewController) {
                      this.webViewController = webViewController;
                    },
                  )
                else
                  const NoInternetWidget(),
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
