import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _kLanguageCode = "language";
  static final String _kAlerts = "alerts";

  static Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kLanguageCode) ?? 'en';
  }

  static Future<bool> setLanguageCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kLanguageCode, value);
  }

  static Future<String> getAlerts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kAlerts) ?? """{"alert":[]}""";
  }

  static Future<bool> setAlerts(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kAlerts, value);
  }

}
