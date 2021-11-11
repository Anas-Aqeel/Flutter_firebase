import 'package:flutter/material.dart';

class Waiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/images.png',
                height: 70,
              ),
              SizedBox(height: 10),
              Text('Firebase App')
            ],
          ),
        ),
      ),
    );
  }
}
