import 'package:intl/intl.dart';
import 'package:task_10/constants/constants_resources.dart';

extension FutureDateTimeParsing on String {
  Future<DateTime?> toFutureDateTime(
      {String format = ConstantsResources.DATE_FORMAT}) async {
    try {
      return DateFormat(format).parse(this);
    } catch (e) {
      return null;
    }
  }

  Future<bool> isFutureDateTime(
      {String format = ConstantsResources.DATE_FORMAT}) async {
    DateTime? dateTime = await toFutureDateTime(format: format);
    if (dateTime != null) {
      return dateTime.isAfter(DateTime.now());
    }
    return false;
  }
}
