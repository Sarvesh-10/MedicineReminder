import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_reminder_/addmedicine.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:medicine_reminder_/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Reminder',
      theme: ThemeData(
        primaryColor: const Color(0xff1F51FF),
      ),
      home: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 1;
  // ignore: non_constant_identifier_names
  final Screen = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[index],
      bottomNavigationBar: BottomNavyBar(
          selectedIndex: index,
          items: [
            BottomNavyBarItem(
                icon: const Icon(Icons.calendar_month_outlined),
                title: const Text('Calendar'),
                activeColor: const Color(0xffFF5F1F),
                inactiveColor: const Color(0xff1F51FF),
                textAlign: TextAlign.center),
            BottomNavyBarItem(
                icon: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                activeColor: const Color(0xffFF5F1F),
                inactiveColor: const Color(0xff1F51FF),
                textAlign: TextAlign.center),
            BottomNavyBarItem(
                icon: const Icon(Icons.person),
                title: const Text('Profile'),
                activeColor: const Color(0xffFF5F1F),
                inactiveColor: const Color(0xff1F51FF),
                textAlign: TextAlign.center),
            BottomNavyBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
                inactiveColor: const Color(0xff1F51FF),
                activeColor: const Color(0xffFF5F1F),
                textAlign: TextAlign.center),
          ],
          onItemSelected: (index) {
            setState(() {
              this.index = index;
            });
          }),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.medication_outlined),
        elevation: 9.0,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddMeds();
          }));
        },
        backgroundColor: const Color(0xff1F51FF),
        foregroundColor: Colors.white,
        label: const Text(
          'Add Medicine',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute(this.child, {required RoutePageBuilder pageBuilder})
      : super(pageBuilder: pageBuilder);

      
}
