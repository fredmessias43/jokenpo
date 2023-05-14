// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

abstract class Item {
  double x;
  double y;
  String imageSrc;
  String name;
  String id;
  String type;

  double width = 32;
  double height = 32;

  double dirX = Random().nextBool() ? 1 : -1;
  double dirY = Random().nextBool() ? 1 : -1;

  double velX = 1;
  double velY = 1;

  Item({
    required this.x,
    required this.y,
    required this.imageSrc,
    required this.name,
    required this.id,
    required this.type,
  });

  move() {
    x += dirX * velX;
    y += dirY * velY;
  }

  checkBoundaries(Size mediaQuerySize) {
    if (x > mediaQuerySize.width - width || x < 0) {
      dirX *= -1;
    }
    if (y > mediaQuerySize.height - height || y < 0) {
      dirY *= -1;
    }
  }

  checkCollision(Item item) {
    if ((x + width) == (item.x + width)) {
      dirX *= -1;
    }
    if ((y + height) == (item.y + height)) {
      dirY *= -1;
    }
  }

  checkCollisionInItems(List<Item> items) {
    var newItems = items.sublist(0);
    newItems.removeWhere((element) => element.hashCode == hashCode);
    for (var item in newItems) {
      checkCollision(item);
    }
  }

  update(context, List<Item> items) {
    move();
    checkBoundaries(MediaQuery.of(context).size);
    checkCollisionInItems(items);
  }

  Widget render() {
    return Positioned(
      top: y,
      left: x,
      width: width,
      height: height,
      child: Image.asset(imageSrc),
    );
  }
}
