class WaterDayRecord {
  DateTime date;
  int intake;
  WaterDayRecord(this.date, this.intake);
}

/// Returns List<WaterDayRecords> when a properly formatted string [text] is passed.
///
/// Accepted format of string: YYYY-MM-DD INTAKE seperated by newline.
List<WaterDayRecord> parseRecordListFromString(String text) {
  print('Parsing record $text');
  var recordList = List<WaterDayRecord>();
  var recordSoup = text.split('\n');
  recordSoup.removeLast();
  print('Record soup: $recordSoup');
  recordSoup.forEach((record) {
    print('SPLITTING: ${record.split(' ')}');
    var dateSoup = record.split(' ').first.split('-');
    var intake = int.parse(record.split(' ').last);
    DateTime newDate = DateTime.utc(
        int.parse(dateSoup[0]), int.parse(dateSoup[1]), int.parse(dateSoup[2]));
    recordList.add(WaterDayRecord(newDate, intake));
  });
  return recordList;
}

/// Returns the formatted String representation of when [recordList] is passed.
///
/// The returned string is compatible with the function parseRecordListFromString.
String convertRecordListToString(List<WaterDayRecord> recordList) {
  String text = '';
  recordList.forEach((record) {
    text = text +
        '${record.date.year}-${record.date.month}-${record.date.day} ${record.intake}\n';
  });
  return text;
}

/// Returns today's record from the passed list if present, else returns null.
///
/// Returns null if the record is not found.
WaterDayRecord getTodayFromRecordList(List<WaterDayRecord> recordList) {
  WaterDayRecord lastRecord = recordList.last;
  DateTime today = DateTime.now();
  if (lastRecord.date.year == today.year &&
      lastRecord.date.month == today.month &&
      lastRecord.date.day == today.day) {
    return lastRecord;
  }
  recordList.add(WaterDayRecord(DateTime.now(), 0));
  return recordList.last;
}

/// Updates today's record intake value and returns the updated record list.
///
/// Replaces existing intake if today exists, or adds new entry if it does not already exist.
List<WaterDayRecord> updateTodayIntakeInRecordList(
    int intake, List<WaterDayRecord> recordList) {
  WaterDayRecord lastRecord = recordList.last;
  DateTime today = DateTime.now();
  if (lastRecord.date.year == today.year &&
      lastRecord.date.month == today.month &&
      lastRecord.date.day == today.day) {
    recordList.last.intake = intake;
  } else {
    recordList.add(WaterDayRecord(today, intake));
  }
  return recordList;
}
