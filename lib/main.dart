import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

import 'package:flutter/material.dart';
import 'package:iweep/model_scoped/alerts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iweep/localization/GlobalTranslations.dart';
import 'package:iweep/screens/home/home_page.dart';

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
              home: HomePage(),
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