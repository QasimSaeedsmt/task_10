// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:task_10/constants/string_resources.dart';
import 'package:task_10/utils/pick_date_time_dialog.dart';

class CustomDialog {
  void showCustomDialog(BuildContext context, bool isInvalidTimeDialog,
      String content, bool isNonEditableDialog) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: isInvalidTimeDialog
              ? const Text(StringResources.INVALID_TIME_LABEL)
              : isNonEditableDialog
                  ? const Text(StringResources.ALARM_PASSED_LABEL)
                  : null,
          content: isInvalidTimeDialog
              ? const Text(StringResources.INVALID_TIME_MSG)
              : isNonEditableDialog
                  ? Text(content)
                  : null,
          actions: [
            !isNonEditableDialog
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(StringResources.CANCEL_LABEL))
                : const SizedBox(),
            ElevatedButton(
                onPressed: isInvalidTimeDialog
                    ? () async {
                        await selectDateTime(context);
                        Navigator.pop(context);
                      }
                    : isNonEditableDialog
                        ? () {
                            Navigator.pop(context);
                          }
                        : null,
                child: isInvalidTimeDialog
                    ? const Text(StringResources.CHANGE_LABEL)
                    : isNonEditableDialog
                        ? const Text(StringResources.OK_LABEL)
                        : null)
          ],
        );
      },
    );
  }
}
