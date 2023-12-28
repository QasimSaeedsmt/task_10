// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:task_10/constants/audio_resources.dart';
import 'package:task_10/constants/constants_resources.dart';
import 'package:task_10/constants/string_resources.dart';

import '../constants/dimensions_resources.dart';
import '../utils/custom_bottom_sheet.dart';

class AlarmRepo {
  static final Map<int, StreamSubscription<AlarmSettings>> _subscriptions = {};

  void setAlarm(
    Future<DateTime?> dateTimeFuture,
    int id,
    BuildContext context,
  ) async {
    cancelAlarmSubscription(id);

    DateTime? dateTime = await dateTimeFuture;
    if (dateTime != null) {
      final alarmSettings = AlarmSettings(
        id: id,
        dateTime: dateTime,
        assetAudioPath: AudioResources.ALARM_TUNE,
        loopAudio: true,
        vibrate: true,
        volume: ConstantsResources.ALARM_VOLUME,
        fadeDuration: DimensionResources.D_3,
        notificationTitle: StringResources.ALARM_TITLE_LABEL,
        notificationBody: StringResources.ALARM_BODY_LABEL,
        enableNotificationOnKill: true,
      );
      await Alarm.set(alarmSettings: alarmSettings);

      if (_subscriptions.containsKey(id)) {
        // If a subscription for this id already exists, cancel it before creating a new one
        _subscriptions[id]?.cancel();
      }
      _subscriptions[id] = Alarm.ringStream.stream.listen((alarmSettings) {
        try {
          CustomBottomSheet().showCustomBottomSheet(context, alarmSettings.id);
        } catch (e) {
          throw Exception(e);
        }
      });
    } else {
      // Handle the case where dateTime is null
    }
  }

  void cancelAlarmSubscription(int id) {
    // Cancel the subscription for the given id when it's no longer needed
    _subscriptions[id]?.cancel();
    _subscriptions.remove(id);
  }

  void cancelAllSubscriptions() {
    // Cancel all subscriptions when they are no longer needed
    _subscriptions.forEach((id, subscription) {
      subscription.cancel();
    });
    _subscriptions.clear();
  }
}
