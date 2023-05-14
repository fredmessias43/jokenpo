import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jokenpo/models/item.dart';
import 'package:jokenpo/models/paper.dart';
import 'package:jokenpo/models/rock.dart';
import 'package:jokenpo/models/scissors.dart';

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
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mediaQuerySize = MediaQuery.of(context).size;
      items = List.generate(50, (index) {
        var limit = 32;
        var x =
            _random.nextInt(mediaQuerySize.width.round() - limit).toDouble();
        var y =
            _random.nextInt(mediaQuerySize.height.round() - limit).toDouble();

        return [Rock(x, y), Paper(x, y), Scissors(x, y)][_random.nextInt(3)];
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
