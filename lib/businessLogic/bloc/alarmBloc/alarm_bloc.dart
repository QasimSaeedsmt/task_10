import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_10/businessLogic/bloc/alarmBloc/alarm_event.dart';
import 'package:task_10/data/data_model/alarm_model.dart';
import 'package:task_10/repo/hive_repo.dart';

import '../../../data/boxes.dart';
import 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  late final Box<AlarmModel> box;

  AlarmBloc() : super(AlarmInitial()) {
    box = Boxes.getData();

    on<UpdateAlarmEvent>((event, emit) => emit(AlarmUpdatedState()));

    on<EditCurrentAlarm>((event, emit) async {
      List<AlarmModel> data = box.values.toList().cast<AlarmModel>();

      HiveRepo().editCurrentAlarm(event.dateOfAlarm, event.index);
      emit(AlarmSetState(
          alarmList: data,
          uniqueID: event.uniqueID,
          dateOfAlarm: event.dateOfAlarm));
    });

    on<SetAlarmEvent>((event, emit) async {
      HiveRepo().saveAlarmToHive(event.uniqueID, event.dateOfAlarm);
      List<AlarmModel> data = box.values.toList().cast<AlarmModel>();
      emit(AlarmSetState(
        alarmList: data,
        uniqueID: event.uniqueID,
        dateOfAlarm: event.dateOfAlarm,
      ));
    });
  }
}
