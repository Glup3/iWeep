import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:iweep/model/alert.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

  
class MyAlarm {

  static AudioPlayer audioPlayer;

  static void playAlarmAsLoop() async {
    AudioCache audioCache = new AudioCache(prefix: 'mp3/');
    audioPlayer = await audioCache.play('alarm1.mp3');
  }

  static void playTheAlarmUntilDateTime(Alert alert, int id) async {
    DateTime now = DateTime.now();
    DateTime alertTime = DateTime(now.year, now.month, now.day, alert.hour, alert.minute, 0);

    if (alertTime.isBefore(now)) {
      alertTime = alertTime.add(Duration(days: 1));
    }
    
    Duration duration = alertTime.difference(now);

    await AndroidAlarmManager.oneShot(duration, id, playAlarmAsLoop);
  }
}
