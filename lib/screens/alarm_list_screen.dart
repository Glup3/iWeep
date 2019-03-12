import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:iweep/widgets/alarm_tile.dart';
import 'package:iweep/model_scoped/alerts.dart';
class AlarmListScreen extends StatelessWidget {

  final ScrollController scrollController;

  AlarmListScreen({this.scrollController});

  @override
  Widget build(BuildContext context) {
      return ScopedModelDescendant<AlertsModel>(
      builder: (BuildContext context, Widget child, AlertsModel model) {
        return Container(
          color: Theme.of(context).canvasColor,
          child: ListView.builder(
            controller: scrollController,
            itemCount: model.alerts.length,
            itemBuilder: (BuildContext context, int index) {
              return AlarmTile(alertIndex: index,);
            },
          ),
        );
      },
    );
  }
}
