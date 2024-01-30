import 'package:hive/hive.dart';
import 'package:task_10/constants/common_keys.dart';
import 'package:task_10/data/data_model/alarm_model.dart';

class Boxes {
  static Box<AlarmModel> getData() =>
      Hive.box<AlarmModel>(CommonKeys.HIVE_BOX_NAME);
}
