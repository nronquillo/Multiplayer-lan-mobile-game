import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game/my_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final game = MyGame();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: GameWidget(game: game)),
    ),
  );
}
