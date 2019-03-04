import 'dart:isolate';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

import 'package:flutter/material.dart';
import 'package:iweep/model_scoped/alerts.dart';
import 'package:iweep/screens/add_alert_screen.dart';
import 'package:iweep/screens/settings_screen.dart';
import 'package:iweep/screens/alarm_list_screen.dart';

main() async {
  final int helloAlarmID = 0;
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
  await AndroidAlarmManager.periodic(
      const Duration(milliseconds: 500), helloAlarmID, printHello);
}

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=$isolateId");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AlertsModel>(
      model: AlertsModel(),
      child: MaterialApp(
        title: 'iWeep',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.purple,
          primaryColor: Colors.blue,
          primaryColorDark: Colors.blue[700],
          primaryColorLight: Colors.blue[200],
          canvasColor: Colors.white,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [];
  bool _isHidden;
  FloatingActionButton _fab;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListener);
    _children.addAll([
      Container(
        color: Colors.blue[300],
        child: AlarmListScreen(
          scrollController: _scrollController,
        ),
      ),
      Container(
        color: Colors.red,
      ),
      SettingsScreen(),
    ]);
    _isHidden = false;
    _fab = _buildFloatingActionButton();

    super.initState();
  }

  void scrollListener() {
    bool value;
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      value = false;
    } else {
      value = true;
    }
    setState(() {
      _isHidden = value;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _children[_currentIndex],
      floatingActionButton: _isHidden ? null : _fab,
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddAlertScreen()));
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm),
          title: Text('Wecker'),
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          title: Text('Statistik'),
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Einstellungen'),
          backgroundColor: Colors.green,
        ),
      ],
      type: BottomNavigationBarType.shifting,
    );
  }

  void onTabTapped(int index) {
    bool value;

    if (index == 0) {
      value = false;
    } else {
      value = true;
    }

    setState(() {
      _currentIndex = index;
      _isHidden = value;
    });
  }
}
