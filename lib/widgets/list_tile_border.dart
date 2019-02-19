import 'package:flutter/material.dart';

class ListTileBorder extends StatelessWidget {
  final Widget child;

  ListTileBorder({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: child,
    );
  }
}
