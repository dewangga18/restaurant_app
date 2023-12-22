import 'package:hive_flutter/hive_flutter.dart';

class HiveScheduleService {
  static final box = Hive.box('schedule');
  static const String key = 'schedule-key';

  static bool isSchedule() {
    bool? result = box.get(key);
    return result ?? false;
  } 

  static void doOrRemoveSchedule(bool value) {
    box.put(key, value);
  } 
}