// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicineType {
  String name;
  Image image;
  bool isSelected;
  MedicineType(this.name, this.image, this.isSelected);
}

class Medicine {
  String name;
  int amount;
  String type;
  int weeksOrDays;
  int freqPerDay;
  Image pillImage;
  String pillImageDesc;
  DateTime date;
  TimeOfDay time;
  Medicine(this.name, this.amount, this.date, this.freqPerDay, this.pillImage,
      this.pillImageDesc, this.time, this.type, this.weeksOrDays);
}
