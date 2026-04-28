import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../components/player.dart';

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(Player(position: Vector2(200, 400), color: Color(0xFF00FFAA)));
  }
}
