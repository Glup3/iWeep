import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:iweep/model_scoped/alerts.dart';
import 'package:iweep/model/alert.dart';
import 'package:numberpicker/numberpicker.dart';

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  int _hour;
  int _minute;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AlertsModel>(
      builder: (BuildContext context, Widget child, AlertsModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedAlert);
        String appBarTitle = "Add Alert";

        if (model.selectedAlertedIndex != null) {
          appBarTitle = "Edit Alert";
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              appBarTitle,
              style: Theme.of(context).textTheme.body1,
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
          RotatedBox(child: Icon(Icons.remove), quarterTurns: 1),
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
            'Okay',
            style: Theme.of(context).textTheme.body1,
          ),
          onPressed: () {
            Alert alert = Alert(
              active: model.selectedAlertedIndex == null
                  ? true
                  : model.selectedAlert.active,
              hour: _hour,
              minute: _minute,
              method: "normal",
              days: Days(
                  monday: true,
                  tuesday: false,
                  wednesday: true,
                  thursday: false,
                  friday: true,
                  saturday: false,
                  sunday: true),
            );

            if (model.selectedAlertedIndex == null) {
              model.addAlert(alert);
            } else {
              model.updateAlert(alert);
            }

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
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildHourPicker(alert),
                Text(
                  ':',
                  style: Theme.of(context).textTheme.body1,
                ),
                _buildMinutePicker(alert),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return FlatButton(
      child: Text(
        'Abbrechen',
        style: Theme.of(context).textTheme.body1,
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
}
