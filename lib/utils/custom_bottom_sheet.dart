// ignore_for_file: use_build_context_synchronously

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_10/businessLogic/bloc/alarmBloc/alarm_bloc.dart';
import 'package:task_10/businessLogic/bloc/alarmBloc/alarm_event.dart';
import 'package:task_10/constants/dimensions_resources.dart';
import 'package:task_10/constants/string_resources.dart';

class CustomBottomSheet {
  void showCustomBottomSheet(BuildContext context, int id) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            await Alarm.stop(id);
            context.read<AlarmBloc>().add(UpdateAlarmEvent());
            Navigator.pop(context);
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(DimensionResources.D_16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    StringResources.RINGING_ALARM_TITLE,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: DimensionResources.D_18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: DimensionResources.D_36),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.circular(DimensionResources.D_9),
                      ),
                      height: DimensionResources.D_60,
                      width: DimensionResources.D_360,
                      child: InkWell(
                        onTap: () async {
                          await Alarm.stop(id);
                          context.read<AlarmBloc>().add(UpdateAlarmEvent());
                          Navigator.pop(context);
                        },
                        child: const Center(
                          child: Text(
                            StringResources.STOP_ALARM_LABEL,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
