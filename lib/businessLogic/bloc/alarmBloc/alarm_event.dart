abstract class AlarmEvent {}

class SetAlarmEvent extends AlarmEvent {
  int uniqueID;

  Future<DateTime?> dateOfAlarm;

  SetAlarmEvent({
    required this.uniqueID,
    required this.dateOfAlarm,
  });
}

class EditCurrentAlarm extends AlarmEvent {
  int uniqueID;
  int index;
  Future<DateTime?> dateOfAlarm;

  EditCurrentAlarm({
    required this.index,
    required this.uniqueID,
    required this.dateOfAlarm,
  });
}

class UpdateAlarmEvent extends AlarmEvent {}
