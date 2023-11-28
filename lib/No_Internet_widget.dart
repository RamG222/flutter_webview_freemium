// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //returns a widget when there is no internet conncetion
    return const Center(
      child: Text('NO INTERNET CONNCETION'),
    );
  }
}
