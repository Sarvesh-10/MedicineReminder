// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:medicine_reminder_/Medicine.dart';
import 'package:medicine_reminder_/addmedicine.dart';

List<MedicineType> medTypeList = [
  MedicineType('Capsule', Image.asset('Images/capsules.png'), true),
  MedicineType('Cream', Image.asset('Images/cream.png'), false),
  MedicineType('Drops', Image.asset('Images/drops.png'), false),
  MedicineType('Pills', Image.asset('Images/icons8-pills-48.png'), false),
  MedicineType('Syringe', Image.asset('Images/syringe.png'), false),
  MedicineType('Syrup', Image.asset('Images/syrup.png'), false),
];
