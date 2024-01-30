import 'package:hive/hive.dart';

part 'alarm_model.g.dart';

@HiveType(typeId: 0)
class AlarmModel extends HiveObject {
  @HiveField(0)
  final int uniqueID;

  @HiveField(1)
  String date;

  @HiveField(2)
  bool alarmTimePassed;

  AlarmModel({
    this.alarmTimePassed = false,
    required this.uniqueID,
    required this.date,
  });
}
