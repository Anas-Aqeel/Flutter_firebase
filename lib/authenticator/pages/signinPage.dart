import 'package:firebase_crud/authenticator/controllers/signin.dart';
import 'package:flutter/material.dart';

var secureTxt = true;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Container(
              // alignment: Alignment.center,
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
                        "Login here to proceed",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 35,
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
                          suffixIcon: IconButton(
                            onPressed: () {
                              togglepassword();
                            },
                            icon: Icon(secureTxt
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
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
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text(
                              "Create Account",
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
                          bool result = await signin(email.text, password.text);
                          if (result) {
                            Navigator.pushNamed(context, '/home');
                          }
                        },
                        splashColor: Colors.black,
                        // padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: Colors.blueAccent, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
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
