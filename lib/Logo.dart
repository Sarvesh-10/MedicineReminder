import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Logo extends StatelessWidget {
  final image;
  Logo({this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(40),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: image,
        ),
      ),
    );
  }
}
