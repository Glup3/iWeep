import 'package:flutter/material.dart';
import '../model/alert.dart';
import '../util/formatting_helper.dart';
import 'package:iweep/localization/GlobalTranslations.dart';

class AlarmTile extends StatefulWidget {

  final Alert alert;

  AlarmTile({Key key, this.alert}) : super(key: key);

  @override
  _AlarmTileState createState() => _AlarmTileState();
}

class _AlarmTileState extends State<AlarmTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(FormattingHelper.formatToTimeString(widget.alert.hour, widget.alert.minute)),
        trailing: Switch(
          value: widget.alert.active,
          activeColor: Theme.of(context).accentColor,
          onChanged: (value) {
            setState(() {
              widget.alert.active = value;
            });
          },
        ),
        leading: Icon(Icons.hourglass_empty),
        subtitle: Text("weekdays"),
      ),
      color: widget.alert.active ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight,
    );
  }
}
