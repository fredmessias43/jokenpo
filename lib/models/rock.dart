import 'dart:math';

import 'package:jokenpo/models/item.dart';

class Rock extends Item {
  Rock(double x, double y)
      : super(
          x: x,
          y: y,
          imageSrc: "assets/images/rock.png",
          name: "Rock",
          type: "rock",
          id: Random().nextInt(1000).toString(),
        );
}
