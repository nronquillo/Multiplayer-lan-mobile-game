import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../components/player.dart';

class MyGame extends FlameGame {
  late final JoystickComponent joystick;
  Player? player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 30,
        paint: Paint()..color = const Color(0xAAFFFFFF),
      ),
      background: CircleComponent(
        radius: 70,
        paint: Paint()..color = const Color(0x55FFFFFF),
      ),
      margin: const EdgeInsets.only(left: 40, bottom: 60),
    );

    player = Player(
      position: Vector2(200, 400),
      color: const Color(0xFF00FFAA),
    );

    add(player!);
    add(joystick);
  }

  @override
  void update(double dt) {
    super.update(dt);
    player?.velocity = joystick.relativeDelta;
  }
}
