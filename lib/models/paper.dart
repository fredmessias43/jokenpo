import 'dart:math';

import 'package:jokenpo/models/item.dart';

class Paper extends Item {
  Paper(double x, double y)
      : super(
          x: x,
          y: y,
          imageSrc: "assets/images/paper.png",
          name: "Paper",
          type: "paper",
          id: Random().nextInt(1000).toString(),
        );
}
