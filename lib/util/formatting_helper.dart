import 'package:iweep/localization/GlobalTranslations.dart';

class FormattingHelper {
  static String formatIntegerToTimeString(int number) {
    return number > 9 ? number.toString() : "0" + number.toString();
  }

  static String formatToTimeString(int hours, int minutes) {
    return formatIntegerToTimeString(hours) + ":" + formatIntegerToTimeString(minutes);
  }

  static String getDayAsStringFromNumber(int day) {
    switch (day) {
      case 1: return allTranslations.text('monday');
      case 2: return allTranslations.text('tuesday');
      case 3: return allTranslations.text('wednesday');
      case 4: return allTranslations.text('thursday');
      case 5: return allTranslations.text('friday');
      case 6: return allTranslations.text('saturday');
      case 7: return allTranslations.text('sunday');
      default: return '???';
    }
  }
}