import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:audioplayers/audio_cache.dart';

class MyAlarm {
  static AudioCache player = new AudioCache(prefix: 'mp3/');

  static void playAlarmAsLoop() {
    player.loop('alarm1.mp3');
  }

  static void playTheAlarm(Duration duration, int id) async {
    await AndroidAlarmManager.oneShot(duration, id, playAlarmAsLoop);
  }
}