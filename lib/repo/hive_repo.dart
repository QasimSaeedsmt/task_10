import 'package:intl/intl.dart';

import '../constants/constants_resources.dart';
import '../data/boxes.dart';
import '../data/data_model/alarm_model.dart';

class HiveRepo {
  var box = Boxes.getData();

  saveAlarmToHive(int uniqueID, Future<DateTime?> date) async {
    DateTime? dateTime = await date;

    if (dateTime != null) {
      DateFormat formatter = DateFormat(ConstantsResources.DATE_FORMAT);
      String formattedTime = formatter.format(dateTime);

      var data = AlarmModel(
        uniqueID: uniqueID,
        date: formattedTime,
      );
      box.add(data);
      data.save();
    } else {}
  }

  editCurrentAlarm(Future<DateTime?> date, int index) async {
    List<AlarmModel> data = box.values.toList().cast<AlarmModel>();
    DateTime? dateTime = await date;

    if (dateTime != null) {
      DateFormat formatter = DateFormat(ConstantsResources.DATE_FORMAT);
      String formattedTime = formatter.format(dateTime);

      data[index].date = formattedTime;
    } else {}
  }
}
