import 'package:flutter/material.dart';

class MyThemes {
  static List<ThemeData> list = [
    ThemeData(
      accentColor: Colors.purple,
      primaryColor: Colors.lightBlue,
      primaryColorDark: Colors.lightBlue,
      primaryColorLight: Colors.lightBlue,
      canvasColor: Colors.indigo,
      primaryIconTheme: IconThemeData(
        color: Colors.white
      ),
      textTheme: TextTheme(
        title: TextStyle(color: Colors.black),
        body1: TextStyle(color: Colors.black),
        body2: TextStyle(color: Colors.white),
        subtitle: TextStyle(color: Colors.black),
        headline: TextStyle(color: Colors.white),
      ),
      cardColor: Colors.white,
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
      primaryColor: Colors.black,
      primaryColorDark: Colors.purple[750],
      primaryColorLight: Colors.purple[750],
      canvasColor: Colors.black87,
      primaryIconTheme: IconThemeData(
        color: Colors.white
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: TextTheme(
        title: TextStyle(color: Colors.white),
        body1: TextStyle(color: Colors.black),
        body2: TextStyle(color: Colors.white),
        subtitle: TextStyle(color: Colors.white),
        headline: TextStyle(color: Colors.white),
      ),
      cardColor: Colors.grey[800],
    )
  ];
}
