import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import 'day2.dart';

main() {
  group("part1", () {
    test('box has no doubles', () {
      expect(box("abcdef").containsValue(2), false);
    });
    test('box has no triples', () {
      expect(box("abcdef").containsValue(3), false);
    });
    test('box has doubles', () {
      expect(box("bababc").containsValue(2), true);
    });
    test('box has triples', () {
      expect(box("bababc").containsValue(3), true);
    });

    test("checksum sample", () {
      var ids = [
        "abcdef",
        "bababc",
        "abbcde",
        "abcccd",
        "aabcdd",
        "abcdee",
        "ababab"
      ];
      expect(checksum(ids), 12);
    });
  });
  group("part2", () {
    test('checksum sample', () {
      var ids = [
        "abcdef",
        "bababc",
        "abbcde",
        "abcccd",
        "aabcdd",
        "abcdee",
        "ababab"
      ];
      expect(checksum(ids), 12);
    });
    test('common letters sample', () {
      expect(commonLetters(KPair("fghij", "fguij")), "fgij");
    });
  });
}
