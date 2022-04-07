// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Medicine.dart';
import 'constants.dart';

class AddMeds extends StatefulWidget {
  const AddMeds({Key? key}) : super(key: key);

  @override
  State<AddMeds> createState() => _AddMedsState();
}

class _AddMedsState extends State<AddMeds> {
  final _firestore = FirebaseFirestore.instance;
  final nameController = TextEditingController();
  final pillAmountController = TextEditingController();
  DateTime setDate = DateTime.now();
  TimeOfDay setTime = TimeOfDay.now();
  DateFormat dateFormat = DateFormat('dd/MM/yy');
  Color onClickDropDown = Colors.black45;
  double dropDownwidth = 2;
  double sliderValue = 50;
  double sliderValue2 = 50;
  Medicine? meds;
  late SnackBar snackBar;

  get onChanged => null;
  String? selectType = 'ml';
  List<String> list = ['ml', 'mg', 'pills'];
  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back));
        }),
        title: Text('New Reminder'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: const Text(
                "Add Pills",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Enter Pill"s name',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Pills Amount',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      controller: pillAmountController,
                      onChanged: (value) {
                        meds!.amount = value as int;
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  margin: EdgeInsets.only(right: 15),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(
                              width: dropDownwidth, color: onClickDropDown))),
                  child: DropdownButton<String>(
                    items: list.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectType = value;

                        dropDownwidth = 2;
                        onClickDropDown = Colors.blue;
                      });
                    },
                    value: selectType,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(
                "How Long ?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Slider(
                divisions: 10,
                value: sliderValue,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
                inactiveColor: Color.fromARGB(255, 241, 225, 225),
                activeColor: const Color(0xff1F51FF),
                min: 0,
                max: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(
                "$sliderValue weeks",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                "Frequency",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Slider(
                divisions: 10,
                value: sliderValue2,
                onChanged: (value) {
                  setState(() {
                    sliderValue2 = value;
                  });
                },
                inactiveColor: Color.fromARGB(255, 241, 225, 225),
                activeColor: const Color(0xff1F51FF),
                min: 0,
                max: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(
                "$sliderValue2 weeks",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              ),
            ),
            Container(
              height: 120,
              width: double.infinity,
              child: ListView(
                children: [
                  ...medTypeList.map(
                      (e) => ImageContainer(medtype: e, onClick: medTypeClick))
                ],
                scrollDirection: Axis.horizontal,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    final selectedDate = await selectDate(context);
                    if (selectedDate != null) {
                      setState(() {
                        setDate = DateTime(selectedDate.year,
                            selectedDate.month, selectedDate.day);
                        meds?.date = setDate;
                      });
                    }
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        // color: Colors.blue,
                        color: Color.fromRGBO(33, 150, 243, 0.1)),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          dateFormat.format(setDate),
                          style: TextStyle(fontSize: 27, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.calendar_month,
                          size: 27,
                          color: const Color(0xff1F51FF),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final selectedTime = await selectTime(context);
                    if (selectedTime != null) {
                      setState(() {
                        setTime = selectedTime;
                        meds?.time = selectedTime;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Color.fromRGBO(33, 150, 243, 0.1)),
                    child: Row(
                      children: [
                        Text(
                          setTime.format(context),
                          style: TextStyle(fontSize: 27, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.alarm,
                          color: const Color(0xff1F51FF),
                          size: 27,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                onPressed: () {
                  saveMedicine();
                },
                child: Text(
                  'Done',
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xff1F51FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ]),
    );
  }

  Future<DateTime?> selectDate(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
  }

  Future<TimeOfDay?> selectTime(BuildContext context) {
    return showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  void medTypeClick(MedicineType type) {
    setState(() {
      medTypeList.forEach((element) {
        element.isSelected = false;
      });
      medTypeList[medTypeList.indexOf(type)].isSelected = true;
    });
  }

  void saveMedicine() {
    _firestore.collection('Medicines').add({
      'Date': setDate.toString(),
      'Time': setTime.toString(),
      'amount': pillAmountController.text,
      'freqPerday': sliderValue.toString(),
      'name': nameController.text,
      'type': selectType,
      'weekOrdays': sliderValue2.toString(),
    });
    snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Reminder added',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Icon(
            Icons.check,
            color: Colors.white,
          )
        ],
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  }
}

class ImageContainer extends StatelessWidget {
  final MedicineType medtype;
  final Function onClick;
  ImageContainer({required this.medtype, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick(medtype);
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: medtype.isSelected ? const Color(0xff1F51FF) : Colors.white,
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            medtype.image,
            SizedBox(
              height: 5,
            ),
            Text(
              medtype.name,
              style: TextStyle(
                  color: medtype.isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
