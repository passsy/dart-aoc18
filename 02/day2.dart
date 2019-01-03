import 'dart:io';

import 'package:dart_kollection/dart_kollection.dart';

int checksum(List<String> listIds) {
  final boxes = listIds.map(box);

  var doubles = 0;
  var triples = 0;
  for (final box in boxes) {
    if (box.containsValue(2)) doubles++;
    if (box.containsValue(3)) triples++;
  }
  return doubles * triples;
}

KMap<int, int> box(String id) {
  return listFrom(id.codeUnits)
      .groupBy((it) => it)
      .mapValues((entry) => entry.value.size);
}

KPair<String, String> fabricPairs(List<String> boxIds) {
  for (final id1 in boxIds) {
    for (final id2 in boxIds) {
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
  var c1 = listFrom(pair.first.runes);
  var c2 = listFrom(pair.second.runes);
  return String.fromCharCodes(c1.filter((it) => c2.contains(it)).iter);
}

main() {
  List<String> input = File("02/input.txt").readAsLinesSync();

  print("checksum: ${checksum(input)}");

  final pair = fabricPairs(input);
  print("boxes with fabric: $pair");
  print("common letters: ${commonLetters(pair)}");
}
