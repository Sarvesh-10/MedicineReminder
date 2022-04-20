import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('LogOut'),
        onPressed: () async {
          final _auth = FirebaseAuth.instance;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('email');
          _auth.signOut();
          Navigator.pop(context);
        },
      ),
    );
  }
}
