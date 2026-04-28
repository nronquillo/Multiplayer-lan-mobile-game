import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = MyGame();
  runApp(GameWidget(game: game));
}

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    //game loads here
  }
}
