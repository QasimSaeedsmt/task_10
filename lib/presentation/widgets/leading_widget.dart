import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../businessLogic/bloc/alarmBloc/alarm_bloc.dart';
import '../../businessLogic/bloc/alarmBloc/alarm_event.dart';
import '../../constants/string_resources.dart';
import '../../repo/alarm_repo.dart';
import '../../utils/custom_dialog.dart';
import '../../utils/pick_date_time_dialog.dart';

class LeadingWidget extends StatelessWidget {
  const LeadingWidget({
    super.key,
    required this.index,
    required this.isFuture,
    required this.uniqueID,
  });

  final bool isFuture;
  final int uniqueID;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isFuture
          ? () {
              Future<DateTime?> alarmDateTime = selectDateTime(context);
              context.read<AlarmBloc>().add(EditCurrentAlarm(
                    index: index,
                    uniqueID: uniqueID,
                    dateOfAlarm: alarmDateTime,
                  ));
              AlarmRepo().setAlarm(alarmDateTime, uniqueID, context);
            }
          : () {
              CustomDialog().showCustomDialog(context, false,
                  StringResources.TIME_NOT_CHANGING_CONTENT, true);
            },
      icon: Icon(
        Icons.access_alarm,
        color: isFuture ? Colors.blue : Colors.grey,
      ),
    );
  }
}
