import 'dart:io';

import 'package:dart_kollection/dart_kollection.dart';

main() {
  List<String> input = File("04/input.txt").readAsLinesSync();
  final records = listOf(input).map((it) => Record.from(it));

  Guard sleeper = longestSleeper(records);

  print("#${sleeper.id} slep ${sleeper.sleptMostAtMinute()}");
  print("Answer ${int.parse(sleeper.id) * sleeper.sleptMostAtMinute()}");
  // too high 173401
}

Guard merge(KList<Guard> guards) {
  assert(() {
    if (guards.map((it) => it.id).toSet().size != 1) {
      throw "not all guards have the same id";
    }
    return true;
  }());
  final guard = Guard(guards[0].id);
  guard._minutesAsleep = listOf(List.filled(60, 0)).mapIndexed((index, value) {
    return guards.sumBy((it) => it._minutesAsleep[index]);
  });
  return guard;
}

Guard longestSleeper(KList<Record> records) {
  final sorted = records.sortedBy((it) => it.day + it.time);
  final guardsPerDays = mutableListOf<Guard>();
  Guard guard;
  for (var record in sorted.iter) {
    if (record.id != null) {
      if (guard != null) {
        guard.complete();
        guardsPerDays.add(guard);
      }
      guard = Guard(record.id);
    }
    guard.addRecord(record);
  }

  var map = guardsPerDays.groupBy((it) => it.id);
  final mergedDaysGuard = map.mapValues((it) => merge(it.value));

  KCollection<Guard> sortedGuards = mergedDaysGuard.values
      .sortedByDescending<num>((it) => it.minutesAsleep());

  var sleeper = sortedGuards.first();
  return sleeper;
}

final begin = RegExp(r"\[(.*) (.*)\] Guard #(\d.*) begins shift");
final fallAsleep = RegExp(r"\[(.*) (.*)\] falls asleep");
final wakeup = RegExp(r"\[(.*) (.*)\] wakes up");

class Record {
  String day;
  String time;
  bool awake;
  String id;

  Record(this.day, this.time, this.awake, [this.id]);

  Record.from(String record) {
    var match = begin.firstMatch(record);
    if (match != null) {
      day = match[1];
      time = match[2];
      awake = true;
      id = match[3];
      return;
    }
    match = fallAsleep.firstMatch(record);
    if (match != null) {
      day = match[1];
      time = match[2];
      awake = false;
      return;
    }
    match = wakeup.firstMatch(record);
    if (match != null) {
      day = match[1];
      time = match[2];
      awake = true;
      return;
    }
    throw "'$record' not matching";
  }

  @override
  String toString() =>
      'Record{day: $day, minute: $time, awake: $awake, id: $id}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Record &&
          runtimeType == other.runtimeType &&
          day == other.day &&
          time == other.time &&
          awake == other.awake &&
          id == other.id;

  @override
  int get hashCode =>
      day.hashCode ^ time.hashCode ^ awake.hashCode ^ id.hashCode;
}

class Guard {
  final String id;
  KMutableList<int> _minutesAsleep = mutableListOf(List.filled(60, 0));
  var _awake = true;
  final records = mutableListOf<Record>();
  int _cursor = 0;

  Guard(this.id);

  void addRecord(Record record) {
    records.add(record);
    if (!record.time.startsWith("00") || records.size == 1) {
      // first event
    } else {
      final min = int.parse(record.time.split(":")[1]);
      assert(_minutesAsleep.size >= min || _cursor == 0);
      for (_cursor; _cursor < min; _cursor++) {
        if (!_awake) {
          _minutesAsleep[_cursor]++;
        }
      }
      _awake = record.awake;
    }
  }

  void complete() {
    for (_cursor; _cursor < 60; _cursor++) {
      if (!_awake) {
        _minutesAsleep[_cursor]++;
      }
    }
  }

  int sleptMostAtMinute() => _minutesAsleep.indexOf(_minutesAsleep.max());

  int minutesAsleep() => _minutesAsleep.sumBy((it) => it);
}
