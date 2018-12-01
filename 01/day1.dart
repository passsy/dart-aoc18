import 'dart:io';

int changeFrequency(List<int> list) => list.reduce((a, b) => a + b);

int frequencyReachedTwice(List<int> list) {
  final found = [0];
  var freq = 0;
  for (var next in _cycle(list)) {
    freq += next;
    if (found.contains(freq)) {
      return freq;
    } else {
      found.add(freq);
    }
  }
}

Iterable<T> _cycle<T>(List<T> list) sync* {
  while (true) {
    yield* list;
  }
}

main() {
  List<int> frequencies = File("01/input.txt")
      .readAsStringSync()
      .trim()
      .split("\n")
      .map((it) => int.parse(it))
      .toList();

  print(changeFrequency(frequencies));
  print(frequencyReachedTwice(frequencies));
}
