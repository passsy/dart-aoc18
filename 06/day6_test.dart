import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import 'day6.dart';

main() {
  group("sample 1", () {
    var a = Coordinate(1, 1, "A");
    var b = Coordinate(1, 6, "B");
    var c = Coordinate(8, 3, "C");
    var d = Coordinate(3, 4, "D");
    var e = Coordinate(5, 5, "E");
    var f = Coordinate(8, 9, "F");
    final coords = listOf(a, b, c, d, e, f);

    test("area of D is 9", () {
      final areas = areaOf(coords);
      print(areas);
      expect(areas["D"], 9);
      expect(areas["E"], 17);
    });

    test("detect finite coords", () {
      var finite = finiteCoordinates(coords);
      expect(finite, listOf(d, e));
    });

    test("safe area size", () {
      final size = safeAreaSize(coords, 32);
      expect(size, 16);
    });
  });

  test("filterTo", () {
    final other = mutableListOf<String>();
    listOf("a", "b", "c").filterTo(other, (_) => true);
    expect(other, listOf("a", "b", "c"));
  });
}
