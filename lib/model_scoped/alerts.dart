import 'package:scoped_model/scoped_model.dart';
import 'package:iweep/model/alert.dart';

class AlertsModel extends Model {
  Alerts _alerts = Alerts(alert: [
      Alert(active: true, minute: 30, hour: 6, method: "math", days: Days(monday: false, tuesday: false, wednesday: false, thursday: true, friday: true, saturday: false, sunday: true)),
      Alert(active: false, minute: 00, hour: 7, method: "math", days: Days(monday: false, tuesday: false, wednesday: false, thursday: true, friday: true, saturday: false, sunday: true)),
      Alert(active: false, minute: 04, hour: 1, method: "math", days: Days(monday: false, tuesday: false, wednesday: false, thursday: true, friday: true, saturday: false, sunday: true)),
      Alert(active: true, minute: 10, hour: 3, method: "math", days: Days(monday: false, tuesday: false, wednesday: false, thursday: true, friday: true, saturday: false, sunday: true)),
      Alert(active: true, minute: 12, hour: 12, method: "math", days: Days(monday: false, tuesday: false, wednesday: false, thursday: true, friday: true, saturday: false, sunday: true)),
      Alert(active: true, minute: 30, hour: 6, method: "math", days: Days(monday: false, tuesday: false, wednesday: false, thursday: true, friday: true, saturday: false, sunday: true)),
      Alert(active: true, minute: 36, hour: 0, method: "math", days: Days(monday: false, tuesday: false, wednesday: false, thursday: true, friday: true, saturday: false, sunday: true)),
      Alert(active: false, minute: 30, hour: 23, method: "math", days: Days(monday: false, tuesday: false, wednesday: false, thursday: true, friday: true, saturday: false, sunday: true)),
      Alert(active: true, minute: 30, hour: 4, method: "math", days: Days(monday: false, tuesday: false, wednesday: false, thursday: true, friday: true, saturday: false, sunday: true)),
      Alert(active: true, minute: 30, hour: 7, method: "math", days: Days(monday: false, tuesday: false, wednesday: false, thursday: true, friday: true, saturday: false, sunday: true)),
      Alert(active: false, minute: 30, hour: 11, method: "math", days: Days(monday: false, tuesday: false, wednesday: false, thursday: true, friday: true, saturday: false, sunday: true)),
    ]);

  int _selectedAlertIndex;

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
  }

  void updateAlert(Alert alert) {
    _alerts.alert[_selectedAlertIndex] = alert;
    _selectedAlertIndex = null;
  }

  void deleteAlert() {
    _alerts.alert.removeAt(_selectedAlertIndex);
    _selectedAlertIndex = null;
    notifyListeners();
  }

  void selectAlert(int index) {
    _selectedAlertIndex = index;
  }

}