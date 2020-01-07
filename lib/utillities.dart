import 'package:flutter/material.dart';

class Utility {
  static Color c = Colors.red[900];
  static double header = 26;
  static Container contaner(Color color, BuildContext context, Widget child) {
    return Container(
      margin: EdgeInsets.only(right: 16, left: 16, top: 6, bottom: 6),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          height: 45,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 18, left: 18),
            child: child,
          ),
        ),
      ),
    );
  }
}
