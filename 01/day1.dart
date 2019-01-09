import 'dart:io';

import 'package:kotlin_dart/collection.dart';

int changeFrequency(KtList<int> list) => list.reduce((a, b) => a + b);

int frequencyReachedTwice(KtList<int> list) {
  final found = hashSetOf(0);
  var freq = 0;
  for (var next in _cycle(list)) {
    freq += next;
    if (!found.add(freq)) {
      return freq;
    }
  }
}

Iterable<T> _cycle<T>(KtList<T> list) sync* {
  while (true) yield* list.iter;
}

main() {
  KtList<int> frequencies = listFrom(File("01/input.txt").readAsLinesSync())
      .map((it) => int.parse(it));
  print(changeFrequency(frequencies));
  print(frequencyReachedTwice(frequencies));
}
