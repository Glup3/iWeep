import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:iweep/widgets/list_tile_border.dart';
import 'package:iweep/data/my_themes.dart';
import 'package:iweep/localization/GlobalTranslations.dart';

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
          _buildTileHeader(allTranslations.text('tab_settings')),
          ListTileBorder(
            child: CheckboxListTile(
              title: Text(
                allTranslations.text("tab_bag"),
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
              title: Text(allTranslations.text('title_change_theme')),
              onTap: _askedToLead,
            ),
          ),
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
            primaryColor: Theme.of(context).primaryColor == Colors.indigo
                ? Colors.red
                : Colors.indigo));
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
        title: Text(
          allTranslations.text('title_change_language'),
        ),
        onTap: _language,
      ),
    );
  }

  Widget _buildDialogAnswer(String text, LanguageAnswers enumAnswer) {
    return SimpleDialogOption(
      onPressed: () => Navigator.pop(context, enumAnswer),
      child: Text(text),
    );
  }

  Future<void> _language() async {
    LanguageAnswers languageAnswers = await showDialog<LanguageAnswers>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(allTranslations.text('title_select_language')),
            children: <Widget>[
              _buildDialogAnswer('Deutsch', LanguageAnswers.German),
              _buildDialogAnswer('English', LanguageAnswers.English),
              _buildDialogAnswer('Japanisch', LanguageAnswers.Japanese),
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

  Widget _buildTileAbout() {
    return ListTile(
      title: Text(allTranslations.text('tab_about')),
    );
  }
}
