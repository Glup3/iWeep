import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:iweep/widgets/list_tile_border.dart';
import 'package:iweep/data/my_themes.dart';
import 'package:iweep/localization/GlobalTranslations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

enum ThemeAnswers { THEME1, THEME2, THEME3, THEME4, THEME5, THEME6, THEME7 }

enum LanguageAnswers { German, English, Japanese }

class _SettingsScreenState extends State<SettingsScreen> {
  bool _value1 = false;
  bool _value2 = false;
  final String language = allTranslations.currentLanguage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: ListView(
        children: <Widget>[
          new TileHeader(context: context, title: allTranslations.text('tab_settings')),
          ListTileBorder(
            child: CheckboxListTile(
              title: Text(
                allTranslations.text("tab_bag"),
                style: Theme.of(context).textTheme.body2,
              ),
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
              title: Text(
                'Ehrenmann',
                style: Theme.of(context).textTheme.body2,
              ),
              subtitle: Text(
                'Nur für Ehrenmänner',
                style: Theme.of(context).textTheme.body2,
              ),
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
              title: Text(allTranslations.text('title_change_theme'),
                  style: Theme.of(context).textTheme.body2),
              onTap: _askedToLead,
            ),
          ),
          _buildTileLanguage(),
          TileAbout(),
        ],
      ),
    );
  }

  Future<void> _askedToLead() async {
    switch (await showDialog<ThemeAnswers>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              'Select Theme',
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ThemeAnswers.THEME1);
                },
                child:
                    Text('Theme 1', style: Theme.of(context).textTheme.body2),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ThemeAnswers.THEME2);
                },
                child:
                    Text('Theme 2', style: Theme.of(context).textTheme.body2),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ThemeAnswers.THEME3);
                },
                child:
                    Text('Theme 3', style: Theme.of(context).textTheme.body2),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ThemeAnswers.THEME4);
                },
                child:
                    Text('Theme 4', style: Theme.of(context).textTheme.body2),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ThemeAnswers.THEME5);
                },
                child:
                    Text('Theme 5', style: Theme.of(context).textTheme.body2),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ThemeAnswers.THEME6);
                },
                child:
                    Text('Theme 6', style: Theme.of(context).textTheme.body2),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ThemeAnswers.THEME7);
                },
                child:
                    Text('Theme 7', style: Theme.of(context).textTheme.body2),
              ),
            ],
          );
        })) {
      case ThemeAnswers.THEME1:
        DynamicTheme.of(context).setThemeData(MyThemes.list[0]);
        saveThemePreference(0);
        break;
      case ThemeAnswers.THEME2:
        DynamicTheme.of(context).setThemeData(MyThemes.list[1]);
        saveThemePreference(1);
        break;
      case ThemeAnswers.THEME3:
        DynamicTheme.of(context).setThemeData(MyThemes.list[2]);
        saveThemePreference(2);
        break;
      case ThemeAnswers.THEME4:
        DynamicTheme.of(context).setThemeData(MyThemes.list[3]);
        saveThemePreference(3);
        break;
      case ThemeAnswers.THEME5:
        DynamicTheme.of(context).setThemeData(MyThemes.list[4]);
        saveThemePreference(4);
        break;
      case ThemeAnswers.THEME6:
        DynamicTheme.of(context).setThemeData(MyThemes.list[5]);
        saveThemePreference(5);
        break;
      case ThemeAnswers.THEME7:
        DynamicTheme.of(context).setThemeData(MyThemes.list[6]);
        saveThemePreference(6);
        break;
      default:
        break;
    }
  }

  Widget _buildTileLanguage() {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        title: Text(
          allTranslations.text('title_change_language'),
          style: Theme.of(context).textTheme.body2,
        ),
        onTap: _language,
      ),
    );
  }

  Future<void> _language() async {
    LanguageAnswers languageAnswers = await showDialog<LanguageAnswers>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(allTranslations.text('title_select_language'),
                style: Theme.of(context).textTheme.body2),
            children: <Widget>[
              DialogLanguageAnswer(
                  text: 'Deutsch', answer: LanguageAnswers.German),
              DialogLanguageAnswer(
                  text: 'English', answer: LanguageAnswers.English),
              DialogLanguageAnswer(
                  text: 'Japanisch', answer: LanguageAnswers.Japanese),
            ],
          );
        });

    switch (languageAnswers) {
      case LanguageAnswers.German:
        await allTranslations.setNewLanguage(language != 'ger' ? 'ger' : 'ger');
        setState(() {});
        break;
      case LanguageAnswers.English:
        await allTranslations.setNewLanguage(language != 'en' ? 'en' : 'en');
        setState(() {});
        break;
      case LanguageAnswers.Japanese:
        await allTranslations.setNewLanguage(language != 'jap' ? 'jap' : 'jap');
        setState(() {});
        break;
      default:
        break;
    }
  }

  Future<bool> saveThemePreference(int position) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setInt("theme", position);
    return preference.commit();
  }
}

class TileHeader extends StatelessWidget {
  const TileHeader({
    Key key,
    @required this.context,
    @required this.title,
  }) : super(key: key);

  final BuildContext context;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.body2),
    );
  }
}

class TileAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        allTranslations.text('tab_about'),
        style: Theme.of(context).textTheme.body2,
      ),
    );
  }
}

class DialogLanguageAnswer extends StatelessWidget {
  final String text;
  final LanguageAnswers answer;

  DialogLanguageAnswer({Key key, this.text, this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: () => Navigator.pop(context, answer),
      child: Text(text, style: Theme.of(context).textTheme.body2),
    );
  }
}
