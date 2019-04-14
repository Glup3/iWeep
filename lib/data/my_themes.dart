import 'package:flutter/material.dart';

class MyThemes {
  static List<ThemeData> list = [
    ThemeData(
      accentColor: Colors.purple,
      primaryColor: Colors.lightBlue,
      primaryColorDark: Colors.lightBlue,
      primaryColorLight: Colors.lightBlue,
      canvasColor: Colors.indigo,
    ),
    ThemeData(
      accentColor: Colors.cyan,
      primaryColor: Colors.yellow,
      primaryColorDark: Colors.amber,
      primaryColorLight: Colors.black,
      canvasColor: Colors.blueGrey,
    ),
    ThemeData(
      accentColor: Colors.pinkAccent[300],
      primaryColor: Colors.redAccent,
      primaryColorDark: Colors.amber,
      primaryColorLight: Colors.black,
      canvasColor: Colors.teal,
    ),
    ThemeData(
      accentColor: Colors.orange[300],
      primaryColor: Colors.deepOrange,
      primaryColorDark: Colors.yellow,
      primaryColorLight: Colors.red,
      canvasColor: Colors.orange[200],
    ),
    ThemeData(
      accentColor: Colors.black,
      primaryColor: Colors.green,
      primaryColorDark: Colors.cyan,
      primaryColorLight: Colors.lightGreen,
      canvasColor: Colors.green[200],
    ),
    ThemeData(
      accentColor: Colors.blueGrey[300],
      primaryColor: Colors.indigo,
      primaryColorDark: Colors.black,
      primaryColorLight: Colors.black,
      canvasColor: Colors.grey,
    ),
    ThemeData(
      accentColor: Colors.white,
      primaryColor: Colors.purple[750],
      primaryColorDark: Colors.purple[750],
      primaryColorLight: Colors.purple[750],
      canvasColor: Colors.black,
      textTheme: TextTheme(
        body1: TextStyle(color: Colors.white),
        body2: TextStyle(color: Colors.black),
        subtitle: TextStyle(color: Colors.grey[350])
      ),
      cardColor: Colors.grey[850],
    )
  ];
}
