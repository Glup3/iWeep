import 'package:flutter/rendering.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:iweep/data/my_themes.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

import 'package:flutter/material.dart';
import 'package:iweep/model_scoped/alerts.dart';
import 'package:iweep/screens/alert_screen.dart';
import 'package:iweep/screens/settings_screen.dart';
import 'package:iweep/screens/alarm_list_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iweep/localization/GlobalTranslations.dart';
import 'package:iweep/screens/statistic_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iweep/util/shared_preferences_helper.dart';
import 'package:iweep/model/alert.dart';


main() async {
  await allTranslations.init();
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (Brightness brightness) => _buildTheme(brightness),
      themedWidgetBuilder: (BuildContext context, ThemeData theme) =>
          ScopedModel<AlertsModel>(
            model: AlertsModel(),
            child: MaterialApp(
              title: 'iWeep',
              theme: theme,
              home: MyHomePage(),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              // Tells the system which are the supported languages
              supportedLocales: allTranslations.supportedLocales(),
            ),
          ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    return brightness == Brightness.dark
        ? ThemeData.dark().copyWith(
            textTheme: ThemeData.dark().textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
            backgroundColor: Colors.black)
        : ThemeData.light().copyWith(
            textTheme: ThemeData.light().textTheme.apply(
                  bodyColor: Colors.black,
                  displayColor: Colors.black,
                ),
            backgroundColor: Colors.white);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                return Center(child: Text('ERROR LOADING DATA'));
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
    // do anything you need to do if the language changes
    print('Language has been changed to: ${allTranslations.currentLanguage}');
  }
}

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

class MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AlertsModel>(
      builder: (BuildContext context, Widget child, AlertsModel model) {
        return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            model.selectAlert(null);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AlertScreen()));
          },
        );
      },
    );
  }
}
