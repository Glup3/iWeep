import 'package:flutter/material.dart';
import 'package:iweep/localization/GlobalTranslations.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function onTap;

  MyBottomNavigationBar({Key key, this.currentIndex, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm),
          title: Text(
            allTranslations.text('tab_alarm'),
            style: Theme.of(context).textTheme.body1,
          ),
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          title: Text(
            allTranslations.text('tab_graph'),
            style: Theme.of(context).textTheme.body1,
          ),
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text(
            allTranslations.text('tab_settings'),
            style: Theme.of(context).textTheme.body1,
          ),
          backgroundColor: Colors.green,
        ),
      ],
      type: BottomNavigationBarType.shifting,
    );
  }
}