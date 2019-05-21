import 'package:flutter/material.dart';
import '../model/alert.dart';
import '../util/formatting_helper.dart';
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
              style: Theme.of(context).textTheme.title,
            ),
            trailing: Switch(
              value: alert.active,
              activeColor: Theme.of(context).accentColor,
              onChanged: (value) {
                setState(() {
                  alert.active = value;
                });
                model.selectAlert(widget.alertIndex);
                model.updateAlert(alert);
              },
            ),
            leading: Icon(Icons.hourglass_empty),
            subtitle: Text(
              _getDaysAsString(alert),
              style: Theme.of(context).textTheme.subtitle,
            ),
            onTap: () {
              model.selectAlert(widget.alertIndex);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return AlertScreen();
              }));
            },
            onLongPress: () {
              model.selectAlert(widget.alertIndex);
              _showOptionsDialog(alert, model.deleteAlert);
            },
          ),
        );
      },
    );
  }

  Future<void> _showOptionsDialog(Alert alert, Function deleteAlert) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warnung'),
          content: Text('Wollen Sie diesen Alarm wirklich löschen?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Bestätigen'),
              onPressed: () {
                deleteAlert();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _getDaysAsString(Alert alert) {
    String days = '';
    if (alert.days.monday) {
      days += 'Mo ';
    }
    if (alert.days.tuesday) {
      days += 'Tu ';
    }
    if (alert.days.wednesday) {
      days += 'We ';
    }
    if (alert.days.thursday) {
      days += 'Th ';
    }
    if (alert.days.friday) {
      days += 'Fr ';
    }
    if (alert.days.saturday) {
      days += 'Sa ';
    }
    if (alert.days.sunday) {
      days += 'Su';
    }
    return days;
  }
}
