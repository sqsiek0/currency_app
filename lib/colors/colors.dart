import 'package:flutter/material.dart';

class MyColors {
  Color primary;
  Color secondary;
  Color tertiary;
  Color quaternary;

  MyColors(
      {required this.primary,
      required this.secondary,
      required this.tertiary,
      required this.quaternary});
}

MyColors lightTheme = MyColors(
    primary: Colors.white,
    secondary: Colors.black,
    tertiary: Colors.grey,
    quaternary: Colors.blue);

MyColors darkTheme = MyColors(
    primary: Colors.black,
    secondary: Colors.cyan,
    tertiary: Colors.amber,
    quaternary: Colors.green);
