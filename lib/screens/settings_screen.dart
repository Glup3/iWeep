import 'package:flutter/material.dart';
import '../widgets/list_tile_border.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
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
          _buildTileLanguage(),
          _buildTileAbout(),
        ],
      ),
    );
  }
  

  Widget _buildTileHeader(String title) {
    return ListTile(
      title: Text(title, style:TextStyle(color: Theme.of(context).primaryColor)),
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
