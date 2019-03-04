import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:iweep/model_scoped/alerts.dart';
import 'package:iweep/model/alert.dart';
import 'package:numberpicker/numberpicker.dart';

class AddAlertScreen extends StatefulWidget {
  @override
  _AddAlertScreenState createState() => _AddAlertScreenState();
}

class _AddAlertScreenState extends State<AddAlertScreen> {
  int _hour = DateTime.now().hour;
  int _minute = DateTime.now().minute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Alert'),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[300],
        child: Row(
          children: <Widget>[
            Expanded(flex: 1, child: _buildCancelButton()),
            RotatedBox(child: Icon(Icons.remove), quarterTurns: 1),
            Expanded(flex: 1, child: _buildOkayButton()),
          ],
        ),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            _buildHourPicker(),
            _buildMinutePicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildOkayButton() {
    return ScopedModelDescendant<AlertsModel>(
      builder: (BuildContext context, Widget child, AlertsModel model) {
        return FlatButton(
          child: Text('Okay'),
          onPressed: () {
            _addAlert(model.addAlert);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Widget _buildCancelButton() {
    return FlatButton(
      child: Text('Abbrechen'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildHourPicker() {
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

  Widget _buildMinutePicker() {
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

  void _addAlert(Function addAlert) {
    addAlert(Alert(
        active: true,
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
            sunday: true)));
  }
}
