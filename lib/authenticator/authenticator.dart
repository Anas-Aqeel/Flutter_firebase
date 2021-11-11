import 'package:firebase_crud/authenticator/pages/signinPage.dart';
import 'package:firebase_crud/home/homePage.dart';
import 'package:flutter/material.dart';

var user;
var userData;

class AuthFirebase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return user != null ? Home() : Login();
  }
}
