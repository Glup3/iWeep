class FormattingHelper {
  static String formatIntegerToTimeString(int number) {
    return number > 9 ? number.toString() : "0" + number.toString();
  }

  static String formatToTimeString(int hours, int minutes) {
    return formatIntegerToTimeString(hours) + ":" + formatIntegerToTimeString(minutes);
  }

  static String getDayAsStringFromNumber(int day) {
    switch (day) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '???';
    }
  }
}