import 'package:kotlin_dart/collection.dart';
import 'package:test/test.dart';

import 'day1.dart';

main() {
  group("part1", () {
    test('sample', () {
      expect(changeFrequency(listOf(1, -2, 3, 1)), 3);
    });
    test('sample1', () {
      expect(changeFrequency(listOf(1, 1, 1)), 3);
    });
    test('sample2', () {
      expect(changeFrequency(listOf(1, 1, -2)), 0);
    });
    test('sample3', () {
      expect(changeFrequency(listOf(-1, -2, -3)), -6);
    });
  });
  group("part2", () {
    test('sample', () {
      expect(frequencyReachedTwice(listOf(1, -2, 3, 1)), 2);
    });
    test('sample1', () {
      expect(frequencyReachedTwice(listOf(1, -1)), 0);
    });
    test('sample2', () {
      expect(frequencyReachedTwice(listOf(3, 3, 4, -2, -4)), 10);
    });
    test('sample3', () {
      expect(frequencyReachedTwice(listOf(-6, 3, 8, 5, -6)), 5);
    });
    test('sample4', () {
      expect(frequencyReachedTwice(listOf(7, 7, -2, -7, -4)), 14);
    });
  });
}
