import 'package:flutter/rendering.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:iweep/data/my_themes.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter/material.dart';
import 'package:iweep/model_scoped/alerts.dart';
import 'package:iweep/screens/settings_screen.dart';
import 'package:iweep/screens/alarm_list_screen.dart';
import 'package:iweep/localization/GlobalTranslations.dart';
import 'package:iweep/screens/statistic_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iweep/util/shared_preferences_helper.dart';
import 'package:iweep/model/alert.dart';

import './bottom_nav.dart';
import './fab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [];
  bool _isHidden = false;
  ScrollController _scrollController = ScrollController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _initialLoad = false;

  @override
  void initState() {
    super.initState();
    allTranslations.onLocaleChangedCallback = _onLocaleChanged;
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListener);
    _children.addAll([
      AlarmListScreen(scrollController: _scrollController),
      StatisticScreen(),
      SettingsScreen(),
    ]);
    setInitTheme();
  }

  void setInitTheme() async {
    int position = await _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('theme') ?? 0);
    });
    DynamicTheme.of(context).setThemeData(MyThemes.list[position]);
  }

  void scrollListener() {
    setState(() {
      _isHidden = _scrollController.position.userScrollDirection ==
              ScrollDirection.forward
          ? false
          : true;
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
      appBar: AppBar(
        title: Text(
          'iWeep',
          style: Theme.of(context).textTheme.headline,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.access_alarms),
            onPressed: () {
              // Fake it till you make it
              turnOffAlertDialog();
            },
          )
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
      ),
      body: ScopedModelDescendant<AlertsModel>(
        builder: (context, widget, model) {
          return FutureBuilder<String>(
            future: SharedPreferencesHelper.getAlerts(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(allTranslations.text('error_loading_alerts'),));
              }

              if (snapshot.hasData && !_initialLoad) {
                Alerts alerts = Alerts.fromJsonString(snapshot.data);

                for (var alert in alerts.alert) {
                  model.addAlert(alert);
                }

                _initialLoad = true;
              }

              return _children[_currentIndex];
            },
          );
        },
      ),
      floatingActionButton: _isHidden ? null : MyFloatingActionButton(),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _isHidden = index == 0 ? false : true;
    });
  }

  _onLocaleChanged() async {
    print('Language has been changed to: ${allTranslations.currentLanguage}');
  }

  Future<void> turnOffAlertDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              allTranslations.text('alert_is_ringing'),
              style: Theme.of(context).textTheme.body1,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    allTranslations.text('wake_up_message'),
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  allTranslations.text('deactivate'),
                  style: Theme.of(context).textTheme.body1,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
