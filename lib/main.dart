import 'package:firebase_crud/home/pages/createPost.dart';
import 'package:firebase_crud/home/pages/savePost.dart';
import 'package:firebase_crud/home/pages/settings.dart';
import 'package:firebase_crud/home/pages/userPost.dart';
import 'package:firebase_core/firebase_core.dart';
import 'authenticator/pages/signinPage.dart';
import 'authenticator/pages/signupPage.dart';
import 'authenticator/authenticator.dart';
import 'package:flutter/material.dart';
import 'pages/waitingPage.dart';
import 'pages/loadingPage.dart';
import 'pages/errorPage.dart';
import 'home/homePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Error();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: AuthFirebase(),
            routes: {
              '/signin': (context) => Login(),
              '/signup': (context) => Register(),
              '/loading': (context) => Loading(),
              '/error': (context) => Error(),
              '/waiting': (context) => Waiting(),
              '/home': (context) => Home(),
              '/createpost': (context) => CreatePost(),
              '/userpost': (context) => MyPosts(),
              '/savepost': (context) => SavePost(),
              '/settings': (context) => MySettings(),
            },
            debugShowCheckedModeBanner: false,
            title: 'Flutter Fire',
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Waiting();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}
