import 'package:firebase_crud/authenticator/controllers/signup.dart';
import 'package:flutter/material.dart';

var secureTxt = true;
enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController cpassword = TextEditingController();
    final TextEditingController username = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        // padding: EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              maxWidth: 320,
              minWidth: 280,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/images.png',
                        height: 70,
                      ),
                      // SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                            text: 'Flutter',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w800,
                                fontSize: 25),
                            children: [
                              TextSpan(
                                text: ' Fire',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 25),
                              )
                            ]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Register here to proceed",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      enabled: true,
                      hintText: "Username",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      enabled: true,
                      hintText: "Email Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      enabled: true,
                      hintText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: secureTxt,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: cpassword,
                    decoration: InputDecoration(
                      enabled: true,
                      hintText: "Confirm Password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: secureTxt,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signin');
                          },
                          child: Text(
                            "<- Back to Login",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Text("Forgot Password ?",
                            style: TextStyle(fontSize: 13))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                      onPressed: () async {
                        bool result = await signup(email.text, password.text,
                            cpassword.text, username.text);
                        if (result) {
                          Navigator.pushNamed(context, '/home');
                        }
                      },
                      splashColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blueAccent, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void togglepassword() {
    secureTxt = !secureTxt;
    setState(() {});
  }
}
