import 'package:hive/hive.dart';

import '../../../data/boxes.dart';
import '../../../data/data_model/alarm_model.dart';

abstract class AlarmState {}

class AlarmInitial extends AlarmState {}

final Box<AlarmModel> box = Boxes.getData();

class AlarmSetState extends AlarmState {
  int uniqueID;

  Future<DateTime?> dateOfAlarm;
  List<AlarmModel> alarmList;

  int boxLength = box.length;

  AlarmSetState(
      {required this.uniqueID,
      required this.alarmList,
      required this.dateOfAlarm});
}

class AlarmUpdatedState extends AlarmState {
  List<AlarmModel> alarmList = box.values.toList().cast<AlarmModel>();
  int boxLength = box.length;
}
