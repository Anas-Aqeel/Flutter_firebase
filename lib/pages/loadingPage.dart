import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            value: null,
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}
