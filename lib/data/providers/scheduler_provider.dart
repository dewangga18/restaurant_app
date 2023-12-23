import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/helpers/background_services.dart';
import 'package:restaurant_app/utils/helpers/date_time_helper.dart';
import 'package:restaurant_app/utils/hive/hive-services/hive_schedule_service.dart';

class SchedulingProvider extends ChangeNotifier {
  SchedulingProvider() {
    _isScheduled = HiveScheduleService.isSchedule();
    notifyListeners();
  }

  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> setRecomendation(bool value) async {
    HiveScheduleService.doOrRemoveSchedule(value);
    _isScheduled = value;
    notifyListeners();
    if (_isScheduled) {
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
