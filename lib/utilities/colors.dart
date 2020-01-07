import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ColorsD {
  static Color redDefault = Colors.red[900];
}

class TextD extends StatelessWidget {
  final String title;
  final String fontFamily;
  final double fontSize;
  final Color textColor;
  final TextDirection textDirection;
  final double height;
  TextD(
      {this.title = 'test',
      this.fontFamily = 'thin',
      this.fontSize = 12,
      this.textDirection = TextDirection.rtl,
      this.textColor = Colors.grey,
      this.height});
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      this.title,
      textDirection: textDirection,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 1000,
      style: TextStyle(
          decoration: TextDecoration.none,
          height: height,
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor),
    );
  }
}
