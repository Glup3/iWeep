import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:iweep/widgets/list_tile_border.dart';
import 'package:iweep/data/my_themes.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

enum ThemeAnswers {
  THEME1,
  THEME2,
  THEME3,
  THEME4,
  THEME5,
  THEME6,
  THEME7,
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _value1 = false;
  bool _value2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: ListView(
        children: <Widget>[
          _buildTileHeader('Einstellungen'),
          ListTileBorder(
            child: CheckboxListTile(
              title: Text('Stupid'),
              value: _value1,
              activeColor: Colors.purple,
              onChanged: (value) {
                setState(() {
                  _value1 = value;
                });
              },
            ),
          ),
          ListTileBorder(
            child: SwitchListTile(
              title: Text('Ehrenmann'),
              subtitle: Text('Nur für Ehrenmänner'),
              value: _value2,
              activeColor: Colors.purple,
              onChanged: (value) {
                setState(() {
                  _value2 = value;
                });
              },
            ),
          ),
          ListTileBorder(
            child: ListTile(
                title: Text('Change Theme'),
                onTap: _askedToLead,
          ),),
          _buildTileLanguage(),
          _buildTileAbout(),
        ],
      ),
    );
  }

Future<void> _askedToLead() async {
                    switch (await showDialog<ThemeAnswers>(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: const Text('Select Theme'),
                            children: <Widget>[
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context, ThemeAnswers.THEME1);
                                },
                                child: const Text('Theme 1'),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context, ThemeAnswers.THEME2);
                                },
                                child: const Text('Theme 2'),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context, ThemeAnswers.THEME3);
                                },
                                child: const Text('Theme 3'),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context, ThemeAnswers.THEME4);
                                },
                                child: const Text('Theme 4'),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context, ThemeAnswers.THEME5);
                                },
                                child: const Text('Theme 5'),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context, ThemeAnswers.THEME6);
                                },
                                child: const Text('Theme 6'),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context, ThemeAnswers.THEME7);
                                },
                                child: const Text('Theme 7'),
                              ),
                            ],
                          );
                        })) {
                      case ThemeAnswers.THEME1:
                        DynamicTheme.of(context).setThemeData(new ThemeData(
        primaryColor: Theme.of(context).primaryColor == Colors.indigo? Colors.red: Colors.indigo));
                        break;
                        case ThemeAnswers.THEME2:
                        DynamicTheme.of(context).setThemeData(MyThemes.theme2);
                        break;
                        case ThemeAnswers.THEME3:
                        DynamicTheme.of(context).setThemeData(MyThemes.theme3);
                        break;
                        case ThemeAnswers.THEME4:
                        DynamicTheme.of(context).setThemeData(MyThemes.theme4);
                        break;
                        case ThemeAnswers.THEME5:
                        DynamicTheme.of(context).setThemeData(MyThemes.theme5);
                        break;
                        case ThemeAnswers.THEME6:
                        DynamicTheme.of(context).setThemeData(MyThemes.theme6);
                        break;
                        case ThemeAnswers.THEME7:
                        DynamicTheme.of(context).setThemeData(MyThemes.theme7);
                        break;
                      default:
                        DynamicTheme.of(context).setThemeData(MyThemes.theme1);
                        break;
                    }
                  }

  Widget _buildTileHeader(String title) {
    return ListTile(
      title:
          Text(title, style: TextStyle(color: Theme.of(context).primaryColor)),
    );
  }

  Widget _buildTileLanguage() {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        title: Text('Sprache'),
      ),
    );
  }

  Widget _buildTileAbout() {
    return ListTile(
      title: Text('Über'),
    );
  }
}
