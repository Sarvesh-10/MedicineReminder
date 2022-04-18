// ignore: file_names
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_reminder_/LoginPage.dart';
import 'package:medicine_reminder_/home.dart';
import 'package:medicine_reminder_/main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  String _emailAddress = '';
  String _password = '';
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                        color: Color(0xff1F51FF),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    onChanged: (value) {
                      _emailAddress = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null) {
                        return "Email cannot be empty";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      label: Text('Enter your Email'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      hintText: 'Enter your Email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Password cannot be empty';
                      }
                      if (value.length < 6) {
                        return "Password should be greater than six characters";
                      }

                      return null;
                    },
                    onChanged: (value) {
                      _password = value;
                    },
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      label: Text('Enter your Password'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      hintText: 'Enter your Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    elevation: 5,
                    onPressed: () async {
                      final isValid = formKey.currentState!.validate();
                      setState(() {
                        showSpinner = true;
                      });
                      if (isValid) {
                        try {
                          final newUser = _auth.createUserWithEmailAndPassword(
                              email: _emailAddress, password: _password);

                          if (newUser != null) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const MyApp();
                            }));
                          }
                        } on Exception catch (e) {
                          // TODO
                        } finally {
                          showSpinner = false;
                        }
                      } else {
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                    child: Text('Register'),
                    minWidth: 350,
                    height: 42,
                    color: Color(0xff1F51FF),
                    textColor: Colors.white,
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'OR',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Sign up with',
                  style: TextStyle(color: Colors.black45, fontSize: 20),
                ),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Logo(
                          image: Image.asset('Images/google.png'),
                        ),
                        Logo(
                          image: Image.asset('Images/meta.png'),
                        ),
                        Logo(
                          image: Image.asset('Images/twitter.png'),
                        )
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ?',
                      style: TextStyle(color: Colors.black26, fontSize: 19),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }));
                        },
                        child: const Text(
                          'Login Here.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurvedButton extends StatelessWidget {
  final Function onPressed;
  GlobalKey formKey;
  String email;
  String password;
  CurvedButton(
      {required this.onPressed,
      required this.formKey,
      required this.email,
      required this.password});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: MaterialButton(
          onPressed: () {},
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  final image;
  Logo({this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: image,
        ),
      ),
    );
  }
}
