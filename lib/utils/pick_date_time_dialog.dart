// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_10/constants/constants_resources.dart';
import 'package:task_10/constants/string_resources.dart';
import 'package:task_10/utils/custom_dialog.dart';

import '../businessLogic/bloc/alarmBloc/alarm_bloc.dart';
import '../businessLogic/bloc/alarmBloc/alarm_event.dart';

Future<DateTime?> selectDateTime(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(ConstantsResources.LAST_DATE),
  );

  if (pickedDate != null) {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      DateTime selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      DateTime minTime = DateTime.now().add(
          const Duration(minutes: ConstantsResources.MINIMUM_GREATER_TIME));

      if (selectedDateTime.isAfter(minTime)) {
        context.read<AlarmBloc>().add(UpdateAlarmEvent());

        return selectedDateTime;
      } else {
        CustomDialog().showCustomDialog(
            context, true, StringResources.EMPTY_STRING, false);
      }
    }
  }

  return null;
}
