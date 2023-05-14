// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class Item {
  double x;
  double y;
  String id;
  String type;

  double width = 32;
  double height = 32;

  int dirX = Random().nextBool() ? 1 : -1;
  int dirY = Random().nextBool() ? 1 : -1;

  double velX = 1;
  double velY = 1;

  Color debugColor = Colors.red;
  bool colliding = false;

  Item({
    required this.x,
    required this.y,
    required this.id,
    required this.type,
  });

  void move() {
    x += dirX * velX;
    y += dirY * velY;
  }

  void checkBoundaries(Size mediaQuerySize) {
    if (x > mediaQuerySize.width - width || x < 0) {
      dirX *= -1;
    }
    if (y > mediaQuerySize.height - height || y < 0) {
      dirY *= -1;
    }
  }

  void checkCollision(Item item) {
    if (x < item.x + item.width &&
        x + width > item.x &&
        y < item.y + item.height &&
        height + y > item.y) {
      changeDirection();
      checkWinOrLose(item);
      colliding = true;
      // print("X => colide: $name with: ${item.name}");
    } else {
      colliding = false;
    }

    if (colliding && item.colliding) {
      x += 10;
      y += 10;
    }
  }

  void changeDirection() {
    dirX *= -1;
    dirY *= -1;
  }

  void win() {}
  void lose(String winType) {
    type = winType;
  }

  void checkWinOrLose(Item item) {
    if ((type == "scissors" && item.type == "rock") ||
        (type == "rock" && item.type == "paper") ||
        (type == "paper" && item.type == "scissors")) {
      lose(item.type);
      item.win();
      return;
    }

    if ((type == "rock" && item.type == "scissors") ||
        (type == "paper" && item.type == "rock") ||
        (type == "scissors" && item.type == "paper")) {
      win();
      item.lose(type);
      return;
    }

    // draw
    if ((type == "rock" && item.type == "rock") ||
        (type == "paper" && item.type == "paper") ||
        (type == "scissors" && item.type == "scissors")) {
      return;
    }
  }

  void checkCollisionInItems(List<Item> items) {
    var newItems = items.sublist(0);
    newItems.removeWhere((element) => element.hashCode == hashCode);
    for (var item in newItems) {
      checkCollision(item);
    }
  }

  void update(context, List<Item> items) {
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
      child: Image.asset("assets/images/$type.png"),
      // child: Container(
      //   decoration: BoxDecoration(
      //     color: debugColor,
      //   ),
      // ),
    );
  }
}
