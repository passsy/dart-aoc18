import 'dart:io';

import 'package:kotlin_dart/collection.dart';

main() {
  KtList<String> polymer =
      listFrom(File("05/input.txt").readAsLinesSync().first.split(""));
  final result = reducePolymer(polymer);
  print("reduced length: ${result.length}");

  final abc =
      listFrom(Iterable.generate(24).map((i) => String.fromCharCode(i + 97)));

  final tests = abc.associateWith((unit) {
    final p = reducePolymer(polymer.filter((it) => it.toLowerCase() != unit));
    final len = p.length;
    print("$unit -> $len");
    return KPair(p, len);
  });

  final shortest =
      tests.values.minBy<num>((KPair<String, int> result) => result.second);

  print("shortest polymer ${shortest.second}");
}

String reducePolymer(KtList<String> polymer) {
  return polymer.fold(mutableListOf<String>(),
      (KtMutableList<String> list, String unit) {
    final last = list.lastOrNull();
    if (unit != last && unit.toUpperCase() == last?.toUpperCase()) {
      return list.dropLast(1).toMutableList();
    }
    list.add(unit);
    return list;
  }).joinToString(separator: "");
}
