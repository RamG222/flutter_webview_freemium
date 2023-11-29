// ignore_for_file: file_names

import './homepage.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //returns a widget when there is no internet conncetion
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: 250,
          child: Image.asset('assets/no_internet.gif'),
        ),
        SizedBox(height: 20),
        Text('NO INTERNET CONNCETION'),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: FilledButton.tonal(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Homepage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restart_alt_rounded),
                SizedBox(width: 10),
                Text('Retry')
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
