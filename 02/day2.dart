import 'dart:io';

import 'package:dart_kollection/dart_kollection.dart';

int checksum(KList<String> listIds) {
  final boxes = listIds.map((id) => Box(id));

  var doubles = 0;
  var triples = 0;
  for (final box in boxes.iter) {
    if (box.withDoubles) doubles++;
    if (box.withTriples) triples++;
  }
  return doubles * triples;
}

class Box {
  final String id;
  bool withDoubles;
  bool withTriples;

  Box(this.id) {
    final chars = listOf(id.codeUnits);
    final groups =
        chars.groupBy((it) => it).mapValues((entry) => entry.value.size);
    withDoubles = groups.containsValue(2);
    withTriples = groups.containsValue(3);
  }
}

KPair<String, String> fabricPairs(KList<String> boxIds) {
  for (final id1 in boxIds.iter) {
    for (final id2 in boxIds.iter) {
      if (id1 == id2) continue;
      var diff = 0;
      for (var i = 0; i < id1.length; i++) {
        if (diff > 1) break;
        if (id1[i] != id2[i]) {
          diff++;
        }
      }
      if (diff == 1) {
        return KPair(id1, id2);
      }
    }
  }
  throw "not found";
}

String commonLetters(KPair<String, String> pair) {
  var c1 = listOf(pair.first.runes);
  var c2 = listOf(pair.second.runes);
  return String.fromCharCodes(c1.filter((it) => c2.contains(it)).iter);
}

main() {
  KList<String> input = listOf(File("02/input.txt").readAsLinesSync());

  print("checksum: ${checksum(input)}");

  final pair = fabricPairs(input);
  print("boxes with fabric: $pair");
  print("common letters: ${commonLetters(pair)}");
}
