// ignore: file_names
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine_reminder_/LoginPage.dart';
import 'package:medicine_reminder_/home.dart';
import 'package:medicine_reminder_/main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Logo.dart';

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
  bool isObscure = true;

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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    onChanged: (value) {
                      _emailAddress = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email cannot be empty";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xff1F51FF),
                      ),
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
                    obscureText: isObscure,
                    onChanged: (value) {
                      _password = value;
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      label: Text('Enter your Password'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: isObscure
                              ? const Icon(Icons.visibility_off)
                              : Icon(
                                  Icons.visibility,
                                  color: isObscure
                                      ? const Color(0xff1F51FF)
                                      : Colors.red,
                                )),
                      hintText: 'Enter your Password',
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                    autofillHints: const [AutofillHints.email],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    elevation: 5,
                    onPressed: () async {
                      final isValid = formKey.currentState!.validate();

                      if (isValid) {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: _emailAddress, password: _password);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('email', _emailAddress);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const MyApp();
                          }));
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                        } finally {
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      }
                    },
                    child: const Text('Register'),
                    minWidth: 350,
                    height: 42,
                    color: const Color(0xff1F51FF),
                    textColor: Colors.white,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'OR',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'Sign up with',
                  style: TextStyle(color: Colors.black45, fontSize: 20),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account ?',
                      style: TextStyle(color: Colors.black26, fontSize: 19),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const LoginPage();
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

