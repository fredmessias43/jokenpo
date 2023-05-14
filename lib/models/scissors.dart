import 'dart:math';

import 'package:jokenpo/models/item.dart';

class Scissors extends Item {
  Scissors(double x, double y)
      : super(
          x: x,
          y: y,
          imageSrc: "assets/images/scissors.png",
          name: "Scissors",
          type: "scissors",
          id: Random().nextInt(1000).toString(),
        );
}
