import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jokenpo/models/item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _random = Random();

  List<Item> items = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mediaQuerySize = MediaQuery.of(context).size;
      items = List.generate(500, (index) {
        var limit = 32;
        var type = ["rock", "paper", "scissors"][_random.nextInt(3)];
        return Item(
            x: _random.nextInt(mediaQuerySize.width.round() - 32).toDouble(),
            y: _random.nextInt(mediaQuerySize.height.round() - 32).toDouble(),
            type: type,
            id: Random().nextInt(1000).toString());
      });

      final _timer = Timer.periodic(const Duration(milliseconds: 25), (timer) {
        setState(() {
          for (var element in items) {
            element.update(context, items);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var stackItems = items.map((item) => item.render()).toList();

    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: stackItems,
      ),
    );
  }
}
