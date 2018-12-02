import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import 'day2.dart';

main() {
  group("part1", () {
    test('box has no doubles', () {
      expect(Box("abcdef").withDoubles, false);
    });
    test('box has no triples', () {
      expect(Box("abcdef").withTriples, false);
    });
    test('box has doubles', () {
      expect(Box("bababc").withDoubles, true);
    });
    test('box has triples', () {
      expect(Box("bababc").withTriples, true);
    });
  });
  group("part2", () {
    test('checksum sample', () {
      var ids = listOf([
        "abcdef",
        "bababc",
        "abbcde",
        "abcccd",
        "aabcdd",
        "abcdee",
        "ababab"
      ]);
      expect(checksum(ids), 12);
    });
    test('common letters sample', () {
      expect(commonLetters(KPair("fghij", "fguij")), "fgij");
    });
  });
}
