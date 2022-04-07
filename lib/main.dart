import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_reminder_/addmedicine.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xff1F51FF),
      ),
      home: const BottomNavBar(),
    );
  }
}

class NavBarBottom extends StatefulWidget {
  const NavBarBottom({Key? key}) : super(key: key);

  @override
  State<NavBarBottom> createState() => _NavBarBottomState();
}

class _NavBarBottomState extends State<NavBarBottom> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
            activeIcon: Icon(Icons.calendar_month_rounded),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.blue,
          )
        ],
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.black,
        iconSize: 30,
        selectedFontSize: 20,
        unselectedFontSize: 16,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddMeds();
          }));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddMeds();
          }));
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff1F51FF),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
