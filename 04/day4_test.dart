import 'package:kotlin_dart/collection.dart';
import 'package:test/test.dart';

import 'day4.dart';

main() {
  group("parse record", () {
    test('begin shift', () {
      expect(Record.from("[1518-11-01 00:00] Guard #10 begins shift"),
          Record("1518-11-01", "00:00", true, "10"));
    });
    test('falls asleep', () {
      expect(Record.from("[1518-11-01 00:05] falls asleep"),
          Record("1518-11-01", "00:05", false));
    });
    test('wakes up', () {
      expect(Record.from("[1518-11-01 00:25] wakes up"),
          Record("1518-11-01", "00:25", true));
    });
  });

  test("sample part1", () {
    final input = """[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:05] falls asleep
[1518-11-01 00:25] wakes up
[1518-11-01 00:30] falls asleep
[1518-11-01 00:55] wakes up
[1518-11-01 23:58] Guard #99 begins shift
[1518-11-02 00:40] falls asleep
[1518-11-02 00:50] wakes up
[1518-11-03 00:05] Guard #10 begins shift
[1518-11-03 00:24] falls asleep
[1518-11-03 00:29] wakes up
[1518-11-04 00:02] Guard #99 begins shift
[1518-11-04 00:36] falls asleep
[1518-11-04 00:46] wakes up
[1518-11-05 00:03] Guard #99 begins shift
[1518-11-05 00:45] falls asleep
[1518-11-05 00:55] wakes up""";
    final records = listFrom(input.split("\n")).map((it) => Record.from(it));
    final analyzedGuards = processRecords(records);
    var sleeper = longestSleeper(analyzedGuards);
    expect(sleeper.id, "10");
    expect(sleeper.sleptMostAtMinute(), 24);
    expect(sleeper.minutesAsleep(), 50);
  });
}
