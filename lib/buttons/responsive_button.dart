import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final btncolor;
  final textcolor;
  final String buttontext;
  final tapped;
  final boxstyle;

  MyButton(
      {this.btncolor,
      required this.buttontext,
      this.textcolor,
      this.tapped,
      this.boxstyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapped,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          decoration: boxstyle,
          child: Center(
            child: Text(
              buttontext,
              style: TextStyle(
                  color: textcolor, fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
