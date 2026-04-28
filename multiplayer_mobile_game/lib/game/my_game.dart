import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../components/arena.dart';
import '../components/player.dart';
import '../components/attack_joystick.dart';

class MyGame extends FlameGame {
  Player? player;
  JoystickComponent? moveJoystick;
  AttackJoystick? attackJoystick;

  static const double wallThickness = 40;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(Arena(gameSize: size));

    player = Player(
      position: Vector2(size.x * 0.25, size.y / 2),
      color: const Color(0xFF00CC88),
    );
    add(player!);

    moveJoystick = JoystickComponent(
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
    add(moveJoystick!);

    attackJoystick = AttackJoystick(
      onAttack: (direction) => player?.attack(direction),
    );
    add(attackJoystick!);
  }

  @override
  void update(double dt) {
    super.update(dt);

    player?.velocity = moveJoystick?.relativeDelta ?? Vector2.zero();

    final margin = wallThickness + 16.0;
    player?.position.clamp(
      Vector2(margin, margin),
      Vector2(size.x - margin, size.y - margin),
    );
  }
}
