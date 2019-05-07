import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:iweep/model_scoped/alerts.dart';
import 'package:iweep/screens/alert_screen.dart';

class MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AlertsModel>(
      builder: (BuildContext context, Widget child, AlertsModel model) {
        return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            model.selectAlert(null);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AlertScreen()));
          },
        );
      },
    );
  }
}