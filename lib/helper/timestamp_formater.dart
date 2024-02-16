import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formatTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('HH:mm');
    return formatter.format(date);
  }
}
