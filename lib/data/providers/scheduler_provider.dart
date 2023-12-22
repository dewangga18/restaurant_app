import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/helpers/background_services.dart';
import 'package:restaurant_app/utils/helpers/date_time_helper.dart';
import 'package:restaurant_app/utils/hive/hive-services/hive_schedule_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = HiveScheduleService.isSchedule();
 
  bool get isScheduled => _isScheduled;
 
  Future<bool> setRecomendation(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}