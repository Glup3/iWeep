import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import 'package:iweep/model/alert.dart';
import 'package:iweep/util/shared_preferences_helper.dart';

class AlertsModel extends Model {
  Alerts _alerts = Alerts(alert: []);

  int _selectedAlertIndex;
  ThemeData _themeData;

  ThemeData get themeData{
    return _themeData;
  }
  
  void changeThemeData(ThemeData theme) {
    _themeData = theme;
  }

  List<Alert> get alerts {
    return List.from(_alerts.alert);
  }

  int get selectedAlertedIndex {
    return _selectedAlertIndex;
  }

  Alert get selectedAlert {
    if (_selectedAlertIndex == null) {
      return null;
    }

    return _alerts.alert[_selectedAlertIndex];
  }

  void addAlert(Alert alert) {
    _alerts.alert.add(alert);
    _selectedAlertIndex = null;
    notifyListeners();
    _saveAlerts();
  }

  void updateAlert(Alert alert) {
    _alerts.alert[_selectedAlertIndex] = alert;
    _selectedAlertIndex = null;
    notifyListeners();
    _saveAlerts();
  }

  void deleteAlert() {
    _alerts.alert.removeAt(_selectedAlertIndex);
    _selectedAlertIndex = null;
    notifyListeners();
    _saveAlerts();
  }

  void selectAlert(int index) {
    _selectedAlertIndex = index;
  }

  void _saveAlerts() {
    SharedPreferencesHelper.setAlerts(_alerts.toJsonString());
  }
}