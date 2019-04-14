import 'package:flutter/material.dart';
import '../model/alert.dart';
import '../util/formatting_helper.dart';
import 'package:iweep/localization/GlobalTranslations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:iweep/model/alert.dart';
import 'package:iweep/util/formatting_helper.dart';
import 'package:iweep/model_scoped/alerts.dart';
import 'package:iweep/screens/alert_screen.dart';

class AlarmTile extends StatefulWidget {
  final int alertIndex;

  AlarmTile({Key key, this.alertIndex}) : super(key: key);

  @override
  _AlarmTileState createState() => _AlarmTileState();
}

class _AlarmTileState extends State<AlarmTile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AlertsModel>(
      builder: (BuildContext context, Widget child, AlertsModel model) {
        Alert alert = model.alerts[widget.alertIndex];
        return Card(
            child: ListTile(
              title: Text(
                FormattingHelper.formatToTimeString(alert.hour, alert.minute),
                style: Theme.of(context).textTheme.subtitle,
              ),
              trailing: Switch(
                value: alert.active,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  setState(() {
                    alert.active = value;
                  });
                },
              ),
              leading: Icon(Icons.hourglass_empty,color: Colors.grey[300],),
              subtitle: Text(
                "weekdays",
                style: Theme.of(context).textTheme.subtitle,
              ),
              onTap: () {
                model.selectAlert(widget.alertIndex);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return AlertScreen();
                }));
              },
            ),
            color: Theme.of(context).cardColor);
      },
    );
  }
}
