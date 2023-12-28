// ignore_for_file: use_build_context_synchronously
import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_10/businessLogic/bloc/alarmBloc/alarm_event.dart';
import 'package:task_10/constants/constants_resources.dart';
import 'package:task_10/constants/string_resources.dart';
import 'package:task_10/extension/condition_extension.dart';
import 'package:task_10/presentation/widgets/leading_widget.dart';
import 'package:task_10/repo/alarm_repo.dart';
import 'package:task_10/utils/custom_dialog.dart';

import '../businessLogic/bloc/alarmBloc/alarm_bloc.dart';
import '../businessLogic/bloc/alarmBloc/alarm_state.dart';
import '../constants/dimensions_resources.dart';
import '../data/boxes.dart';
import '../data/data_model/alarm_model.dart';
import '../utils/pick_date_time_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var box = Boxes.getData();

  int generateRandomInt(int min, int max) {
    final random = Random();
    return min +
        random.nextInt(max - min + ConstantsResources.MINIMUM_RANDOM_NUMBER);
  }

  @override
  void initState() {
    context.read<AlarmBloc>().add(UpdateAlarmEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AlarmModel> data = box.values.toList().cast<AlarmModel>();
    int boxLength = box.length;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          BlocBuilder<AlarmBloc, AlarmState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  Future<DateTime?> alarmDateTime = selectDateTime(context);
                  int uniqueId = generateRandomInt(
                      ConstantsResources.MINIMUM_RANDOM_NUMBER,
                      ConstantsResources.MAXIMUM_RANDOM_NUMBER);
                  context.read<AlarmBloc>().add(SetAlarmEvent(
                        uniqueID: uniqueId,
                        dateOfAlarm: alarmDateTime,
                      ));
                  AlarmRepo().setAlarm(alarmDateTime, uniqueId, context);
                },
                icon: const Icon(
                  Icons.alarm_add_outlined,
                  size: DimensionResources.D_30,
                ),
              );
            },
          ),
          const SizedBox(width: DimensionResources.D_30),
        ],
        title: const Text(StringResources.ALARM_LABEL),
        centerTitle: true,
      ),
      body: BlocBuilder<AlarmBloc, AlarmState>(
        builder: (context, state) {
          if (state is AlarmUpdatedState) {
            data = state.alarmList;
            boxLength = state.boxLength;
          }
          return ListView.builder(
            itemCount: boxLength,
            itemBuilder: (context, index) {
              String dateString = data[index].date;
              return FutureBuilder<DateTime?>(
                future: dateString.toFutureDateTime(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                        '${StringResources.ERROR_LABEL}${snapshot.error}');
                  } else {
                    DateTime alarmTime = snapshot.data!;
                    bool isFuture = alarmTime.isAfter(DateTime.now());
                    int uniqueID = data[index].uniqueID;
                    return ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: DimensionResources.D_4,
                        right: DimensionResources.D_4,
                      ),
                      leading: LeadingWidget(
                          index: index, isFuture: isFuture, uniqueID: uniqueID),
                      trailing: isFuture
                          ? IconButton(
                              onPressed: () async {
                                Alarm.stop(uniqueID);
                                box.deleteAt(index);
                                context
                                    .read<AlarmBloc>()
                                    .add(UpdateAlarmEvent());
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          : IconButton(
                              color: Colors.grey,
                              onPressed: () async {
                                CustomDialog().showCustomDialog(
                                    context,
                                    false,
                                    StringResources.CANNOT_DELETE_CONTENT,
                                    true);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                            ),
                      title: Text(
                        data[index].date.toString(),
                        style: TextStyle(
                            color: isFuture ? Colors.black : Colors.grey,
                            fontWeight:
                                isFuture ? FontWeight.w700 : FontWeight.w600),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Future<DateTime?> alarmDateTime = selectDateTime(context);
          int uniqueId = generateRandomInt(
              ConstantsResources.MINIMUM_RANDOM_NUMBER,
              ConstantsResources.MAXIMUM_RANDOM_NUMBER);
          context.read<AlarmBloc>().add(SetAlarmEvent(
                uniqueID: uniqueId,
                dateOfAlarm: alarmDateTime,
              ));
          AlarmRepo().setAlarm(alarmDateTime, uniqueId, context);
        },
        child: const Icon(
          Icons.alarm_add,
          size: DimensionResources.D_30,
        ),
      ),
    );
  }
}
