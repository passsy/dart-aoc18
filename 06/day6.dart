import 'package:kotlin_dart/collection.dart';

final _doubleCoord = Coordinate(-1, -1, " .");

KtMap<String, int> areaOf(KtCollection<Coordinate> allCoords) {
  final KtCollection<Coordinate> finiteCoords = finiteCoordinates(allCoords);
  assert(allCoords.containsAll(finiteCoords));
  var N = allCoords.map((c) => c.x > c.y ? c.x : c.y).max() + 1;

  final map = mutableListFrom(List.generate(
      (N), (_) => mutableListFrom(List<Coordinate>.filled(N, null))));

  void printGrid() {
    final buffer = StringBuffer();
    for (int i = 0; i < map.size; i++) {
      for (int j = 0; j < map[0].size; j++) {
        buffer.write(map[j][i]?.name?.padLeft(2) ?? " -");
      }
      buffer.write("\n");
    }
    print(buffer.toString());
  }

  for (final coord in allCoords.iter) {
    map[coord.x][coord.y] = coord;
  }

  var radius = 0;
  while (map.flatMap((it) => it).contains(null)) {
    print("radius $radius");
    //printGrid();
    radius++;
    KtMutableList<Coordinate> thisRoundAdded = mutableListOf<Coordinate>();

    for (final coord in allCoords.iter) {
      final circlePoints = coord.circlePoints(radius);
      for (final p in circlePoints.iter) {
        try {
          var value = map[p.x][p.y];
          if (value == null) {
            // add
            map[p.x][p.y] = coord;
            thisRoundAdded.add(p);
          } else {
            if (thisRoundAdded.contains(p)) {
              map[p.x][p.y] = _doubleCoord;
            }
          }
        } on IndexOutOfBoundsException {
          // ignore
        }
      }
    }
    if (radius > N * 2) {
      throw "radius > ${N * 2}";
    }
  }

  return map
      .flatMap((it) => it)
      .groupBy((it) => it.name)
      .toMutableMap()
      .mapValues((entry) => entry.value.count());
}

int safeAreaSize(KtCollection<Coordinate> allCoords, int maxDistance) {
  var N = allCoords.map((c) => c.x > c.y ? c.x : c.y).max() + 1;

  var points = listFrom(
      Iterable.generate(N, (y) => Iterable.generate(N, (x) => Coordinate(x, y)))
          .expand((it) => it));
  return points
      .map((p) => allCoords.sumBy((c) => c.distance(p)))
      .count((distance) => distance < maxDistance);
}

KtList<Coordinate> finiteCoordinates(KtCollection<Coordinate> coordinates) {
  return coordinates.filter((point) {
    if (point.overflowsRight(coordinates)) {
      print("$point overflows right");
      return false;
    }

    if (point.overflowsLeft(coordinates)) {
      print("$point overflows left");
      return false;
    }

    if (point.overflowsTop(coordinates)) {
      print("$point overflows top");
      return false;
    }

    if (point.overflowsBottom(coordinates)) {
      print("$point overflows bottom");
      return false;
    }

    print("$point is finite");
    return true;
  });
}

class Coordinate {
  Coordinate(this.x, this.y, [this.name]);

  final int x;
  final int y;
  final String name;

  @override
  String toString() {
    return '${name ?? ""}($x, $y)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coordinate &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y &&
          name == other.name;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ name.hashCode;

  static int _uniqueIndex = 0;

  static Coordinate parse(String input) {
    final split = input.split(", ");
    return Coordinate(
        int.parse(split[0]), int.parse(split[1]), (++_uniqueIndex).toString());
  }

  KtSet<Coordinate> circlePoints(int radius) {
    var set = linkedSetOf<Coordinate>();

    set.add(Coordinate(x, y + radius));
    set.add(Coordinate(x, y - radius));
    set.add(Coordinate(x + radius, y));
    set.add(Coordinate(x - radius, y));
    for (int j = 1; j <= radius - 1; j++) {
      set.add(Coordinate(x + j, y + radius - j));
      set.add(Coordinate(x - j, y + radius - j));
      set.add(Coordinate(x + j, y - radius + j));
      set.add(Coordinate(x - j, y - radius + j));
    }
    set.filter((c) => c.distance(this) == radius);
    return set;
  }

  int distance(Coordinate other) {
    return (x - other.x).abs() + (y - other.y).abs();
  }

  bool overflowsRight(KtCollection<Coordinate> set) {
    final rightOf = set.filter((coord) {
      var dx = coord.x - x;
      var dy = coord.y - y;
      return dx > 0 && dy.abs() <= dx.abs();
    });

    return rightOf.isEmpty();
  }

  bool overflowsLeft(KtCollection<Coordinate> set) {
    final leftOf = set.filter((coord) {
      var dx = coord.x - x;
      var dy = coord.y - y;
      return dx < 0 && dy.abs() <= dx.abs();
    });

    return leftOf.isEmpty();
  }

  bool overflowsBottom(KtCollection<Coordinate> set) {
    final bottomOf = set.filter((coord) {
      var dx = coord.x - x;
      var dy = coord.y - y;
      return dy > 0 && dx.abs() <= dy.abs();
    });

    return bottomOf.isEmpty();
  }

  bool overflowsTop(KtCollection<Coordinate> set) {
    final topOf = set.filter((coord) {
      var dx = coord.x - x;
      var dy = coord.y - y;
      return dy < 0 && dx.abs() <= dy.abs();
    });

    return topOf.isEmpty();
  }
}
