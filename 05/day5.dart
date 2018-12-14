import 'dart:io';

import 'package:dart_kollection/dart_kollection.dart';

main() {
  String polymer = File("05/input.txt").readAsLinesSync().first;
  final result = reducePolymer(polymer.split(""));
  print(result.length);
}

String reducePolymer(List<String> polymer) {
  return listOf(polymer).fold(mutableListOf<String>(),
      (KMutableList<String> list, String unit) {
    final last = list.lastOrNull();
    if (unit != last && unit.toUpperCase() == last?.toUpperCase()) {
      return list.dropLast(1).toMutableList();
    }
    list.add(unit);
    return list;
  }).joinToString(separator: "");
}
