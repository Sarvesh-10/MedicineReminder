import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

final _auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateFormat dateFormat = DateFormat('dd/MM/yy');
  late String currentDate = dateFormat.format(DateTime.now());
  late String storedDate;
  late User loggedInUser;
  void getCurrentUser() {
    User? current = _auth.currentUser;
    if (current != null) {
      loggedInUser = current;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              child: Center(
                  child: Text(
                loggedInUser.email.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white),
              )),
              color: const Color(0xffFF5F1F),
              height: 350,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('Medicin').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final medicines = snapshot.data!.docs;

                List<MedContainer> medList = [];

                for (var meds in medicines) {
                  Map medsInfo = meds.data() as Map;
                  storedDate = medsInfo['Date'];
                  if (storedDate == currentDate) {
                    MedContainer newMed = MedContainer(
                        medType: medsInfo['type'],
                        amount: medsInfo['amount'],
                        date: medsInfo['Date'],
                        time: medsInfo['Time'],
                        freqPerDay: medsInfo['freqPerDay'],
                        name: medsInfo['name'],
                        days: medsInfo['days']);
                    medList.add(newMed);
                  }
                }
                return Expanded(
                    child: ListView(
                  children: medList,
                ));
              }

              return const CircularProgressIndicator(
                color: Color(0xffFF5F1F),
              );
            },
          ),
        ]),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double w = size.width;
    double h = size.height;

    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h - 100, w, h);
    path.lineTo(w, 0);
    path.close();

    // ignore: todo
    // TODO: implement getClip
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MedContainer extends StatelessWidget {
  final String date;
  final String time;
  final String amount;
  final String freqPerDay;
  final String name;
  final String medType;
  final String days;

  const MedContainer(
      {Key? key,
      required this.date,
      required this.time,
      required this.amount,
      required this.freqPerDay,
      required this.name,
      required this.days,
      required this.medType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5.0,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            medTypeImage(medType),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$amount $medType',
                style: const TextStyle(
                    color: Color(0xff1F51FF), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Text(name,
            style: const TextStyle(
                color: Color(0xff1F51FF),
                fontWeight: FontWeight.bold,
                fontSize: 17)),
        Text(time,
            style: const TextStyle(
                color: Color(0xff1F51FF), fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Image medTypeImage(String medType) {
    switch (medType) {
      case 'Capusle':
        return Image.asset('Images/capsules.png');
      case 'Cream':
        return Image.asset('Images/cream.png');
      case 'Drops':
        return Image.asset('Images/drops.png');
      case 'Pills':
        return Image.asset('Images/icons8-pills-48.png');
      case 'Syringe':
        return Image.asset('Images/syringe.png');
      case 'Syrup':
        return Image.asset('Images/syrup.png');
    }

    return Image.asset('Images/capsules.png');
  }
}
// return Container(
//       color: const Color(0xffC5CAE9),
//       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//       margin: const EdgeInsets.all(5),
//       child: Column(children: [
//         Text(name),
//         Text(date),
//         Text(time),
//         Text(amount),
//         Text(freqPerDay),
//         Text(weekOrdays),
//       ]),
//     );