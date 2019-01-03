import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import 'day5.dart';

main() {
  group("part 1", () {
    test('reduce sample', () {
      final result = reducePolymer(listFrom("dabAcCaCBAcCcaDA".split("")));
      expect(result, "dabCBAcaDA");
    });

    test('reduce end', () {
      final result = reducePolymer(listFrom("AcCcaDAa".split("")));
      expect(result, "AcaD");
    });
  });
}
