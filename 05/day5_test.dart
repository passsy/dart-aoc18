import 'package:test/test.dart';

import 'day5.dart';

main() {
  group("part 1", () {
    test('reduce sample', () {
      final result = reducePolymer("dabAcCaCBAcCcaDA".split(""));
      expect(result, "dabCBAcaDA");
    });

    test('reduce end', () {
      final result = reducePolymer("AcCcaDAa".split(""));
      expect(result, "AcaD");
    });
  });
}
