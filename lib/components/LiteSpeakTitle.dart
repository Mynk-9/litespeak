import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiteSpeakTitle extends StatefulWidget {
  LiteSpeakTitle(this.fontSize,
      {this.data = "LiteSpeak", this.isAnimated = false});

  final double fontSize;
  final String data;
  final bool isAnimated;
  //String data = "LiteSpeak";

  @override
  _LiteSpeakTitleState createState() =>
      _LiteSpeakTitleState(fontSize, data, isAnimated);
}

class _LiteSpeakTitleState extends State<LiteSpeakTitle> {
  final double headingFontSize;
  final String data;
  final bool isAnimated;
  final int animationDurationMilliseconds = 1000;

  _LiteSpeakTitleState(this.headingFontSize, this.data, this.isAnimated) {
    headingFontList = [
      GoogleFonts.pacifico(
        textStyle: TextStyle(
          fontSize: headingFontSize,
        ),
      ),
    ];
    if (isAnimated) {
      new Timer.periodic(
        Duration(milliseconds: animationDurationMilliseconds),
        (Timer t) => changeFontOfHeading(),
      );
    }
  }

  List<TextStyle> headingFontList;
  int fontIterator = 0;
  void changeFontOfHeading() {
    setState(() {
      if (fontIterator == headingFontList.length - 1) {
        fontIterator = 0;
      } else {
        fontIterator++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      child: Text(
        data,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
      style: headingFontList[fontIterator],
      duration:
          Duration(milliseconds: (animationDurationMilliseconds ~/ 2).toInt()),
      curve: Curves.linear,
    );
  }
}
