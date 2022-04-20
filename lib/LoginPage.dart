// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder_/Registration.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Logo.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _emailAddress = '';
  String _password = '';
  bool isObscure = true;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSpinner = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'LOG IN',
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
                      setState(() {
                        showSpinner = true;
                      });
                      if (isValid) {
                        try {
                          final existingUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: _emailAddress, password: _password);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('email', _emailAddress);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return MyApp();
                          }));
                        } on Exception catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                        } finally {
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      } else {
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                    child: Text('Login'),
                    minWidth: 350,
                    height: 42,
                    color: Color(0xff1F51FF),
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
                  'Login with',
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
                      'New to this platform ?',
                      style: TextStyle(color: Colors.black26, fontSize: 19),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const RegistrationScreen();
                          }));
                        },
                        child: const Text(
                          'Sign Up here !',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ]),
        ),
      )),
    );
  }
}
