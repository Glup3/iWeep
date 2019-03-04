class FormattingHelper {
  static String formatIntegerToTimeString(int number) {
    return number > 9 ? number.toString() : "0" + number.toString();
  }

  static String formatToTimeString(int hours, int minutes) {
    return formatIntegerToTimeString(hours) + ":" + formatIntegerToTimeString(minutes);
  }
}