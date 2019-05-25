import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:iweep/model_scoped/alerts.dart';
import 'package:iweep/model/alert.dart';
import 'package:iweep/util/formatting_helper.dart';
import 'package:iweep/alert/my_alarm.dart';
import 'package:iweep/localization/GlobalTranslations.dart';

enum WakeUpMethod {
  Standard,
  Math,
  Word,
  Shake,
}

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  String _wakeUpMethod = '';
  int _hour;
  int _minute;
  List<bool> _activatedDays;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AlertsModel>(
      builder: (BuildContext context, Widget child, AlertsModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedAlert);
        Alert alert = model.selectedAlert;

        String appBarTitle = allTranslations.text('add_alert');

        if (alert != null) {
          appBarTitle = allTranslations.text('edit_alert');
          _activatedDays = [
            alert.days.monday,
            alert.days.tuesday,
            alert.days.wednesday,
            alert.days.thursday,
            alert.days.friday,
            alert.days.saturday,
            alert.days.sunday,
          ];
        }
        else {
          _activatedDays = [
            false,
            false,
            false,
            false,
            false,
            false,
            false,
          ];
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              appBarTitle,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          body: pageContent,
          backgroundColor: Theme.of(context).canvasColor,
          bottomNavigationBar: _buildBottomNavigationBar(),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: _buildCancelButton()),
          RotatedBox(child: Icon(Icons.remove, color: Theme.of(context).primaryIconTheme.color,), quarterTurns: 1),
          Expanded(flex: 1, child: _buildOkayButton()),
        ],
      ),
    );
  }

  Widget _buildOkayButton() {
    return ScopedModelDescendant<AlertsModel>(
      builder: (BuildContext context, Widget child, AlertsModel model) {
        return FlatButton(
          child: Text(
            allTranslations.text('okay'),
            style: Theme.of(context).textTheme.body2,
          ),
          onPressed: () async {
            Alert alert = Alert(
              active: model.selectedAlertedIndex == null
                  ? true
                  : model.selectedAlert.active,
              hour: _hour,
              minute: _minute,
              method: _wakeUpMethod,
              days: Days(
                monday: _activatedDays[0],
                tuesday: _activatedDays[1],
                wednesday: _activatedDays[2],
                thursday: _activatedDays[3],
                friday: _activatedDays[4],
                saturday: _activatedDays[5],
                sunday: _activatedDays[6],
              ),
            );

            int id = 0;

            if (model.selectedAlertedIndex == null) {
              id = model.alerts.length;
              model.addAlert(alert);
            } else {
              id = model.selectedAlertedIndex;
              model.updateAlert(alert);
            }

            MyAlarm.playTheAlarmUntilDateTime(alert, id);

            Navigator.pop(context);
          },
        );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Alert alert) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _buildCardTimePicker(alert),
          _buildCardDayPicker(alert),
          _buildCardMethodPicker()
        ],
      ),
    );
  }

  Widget _buildCardDayPicker(Alert alert) {
    return Card(
      child: ListTile(
        leading: Text(
          allTranslations.text('repeat'),
          style: Theme.of(context).textTheme.body1, // white theme, black font
        ),
        onTap: () => _showDayPickerDialog(),
        trailing: Text(
          _getDaysAsString(alert),
          style: Theme.of(context).textTheme.body1, // white theme, black font
        ),
      ),
    );
  }

  Future<void> _showDayPickerDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CheckboxDialog(
          activatedDays: _activatedDays,
        );
      },
    );
  }

  Widget _buildCardTimePicker(Alert alert) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildHourPicker(alert),
          Text(':'),
          _buildMinutePicker(alert),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return FlatButton(
      child: Text(
        allTranslations.text('cancel'),
        style: Theme.of(context).textTheme.body2,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildHourPicker(Alert alert) {
    if (_hour == null) {
      _hour = alert != null ? alert.hour : DateTime.now().hour;
    }

    return NumberPicker.integer(
      initialValue: _hour,
      infiniteLoop: true,
      minValue: 0,
      maxValue: 23,
      onChanged: (number) {
        setState(() {
          _hour = number;
        });
      },
    );
  }

  Widget _buildMinutePicker(Alert alert) {
    if (_minute == null) {
      _minute = alert != null ? alert.minute : DateTime.now().minute;
    }

    return NumberPicker.integer(
      initialValue: _minute,
      infiniteLoop: true,
      minValue: 0,
      maxValue: 59,
      onChanged: (number) {
        setState(() {
          _minute = number;
        });
      },
    );
  }

  String _getDaysAsString(Alert alert) {
    String days = '';
    if (alert != null) {
      if (alert.days.monday) { days += 'Mo '; }
      if (alert.days.tuesday) { days += 'Tu '; }
      if (alert.days.wednesday) { days += 'We '; }
      if (alert.days.thursday) { days += 'Th '; }
      if (alert.days.friday) { days += 'Fr '; }
      if (alert.days.saturday) { days += 'Sa '; }
      if (alert.days.sunday) { days += 'Su'; }
    }
    return days;
  }

  Future<void> _showWakeUpMethodDialog() async {
    String method;

    switch (await showDialog<WakeUpMethod> (
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(allTranslations.text('choose_wake_up_method')),
          children: <Widget>[
            SimpleDialogOption(
              child: Text(allTranslations.text('method_standard')),
              onPressed: () {
                Navigator.pop(context, WakeUpMethod.Standard);
              },
            ),
            SimpleDialogOption(
              child: Text(allTranslations.text('method_math')),
              onPressed: () {
                Navigator.pop(context, WakeUpMethod.Math);
              },
            ),
            SimpleDialogOption(
              child: Text(allTranslations.text('method_word')),
              onPressed: () {
                Navigator.pop(context, WakeUpMethod.Word);
              },
            ),
            SimpleDialogOption(
              child: Text(allTranslations.text('method_shake')),
              onPressed: () {
                Navigator.pop(context, WakeUpMethod.Shake);
              },
            ),
          ],
        );
      }
    )) {
      case WakeUpMethod.Standard:
        method = "normal";
        break;
        
      case WakeUpMethod.Math:
        method = "math";
        break;

      case WakeUpMethod.Word:
        method = "word";
        break;

      case WakeUpMethod.Shake:
        method = "shake";
        break;

      default:
        method = "normal";
        break;
    }

    setState(() {
      _wakeUpMethod = method;
    });
  }

  Widget _buildCardMethodPicker() {
    return Card(
      child: ListTile(
        leading: Text(
          allTranslations.text('wake_up_method'),
          style: Theme.of(context).textTheme.body1, // white theme, black font
        ),
        onTap: () => _showWakeUpMethodDialog(),
        trailing: Text(
          _wakeUpMethod,
          style: Theme.of(context).textTheme.body1, // white theme, black font
        ),
      ),
    );
  }

}

class CheckboxDialog extends StatefulWidget {
  final List<bool> activatedDays;

  CheckboxDialog({Key key, this.activatedDays}) : super(key: key);

  @override
  _CheckboxDialogState createState() => _CheckboxDialogState();
}

class _CheckboxDialogState extends State<CheckboxDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        allTranslations.text('choose_weekdays'),
        style: Theme.of(context).textTheme.body1,
      ),
      content: Column(
        children: List.generate(widget.activatedDays.length, (int index) {
          return CheckboxListTile(
            title: Text(
              FormattingHelper.getDayAsStringFromNumber(index+1),
              style: Theme.of(context).textTheme.body1,
            ),
            value: widget.activatedDays[index],
            onChanged: (value) {
              setState(() {
                widget.activatedDays[index] = !widget.activatedDays[index];
              });
            },
            activeColor: Theme.of(context).primaryColor,
          );
        }),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            allTranslations.text('okay'),
            style: Theme.of(context).textTheme.body1,
          ),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
