import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../components/arena.dart';
import '../components/attack_joystick.dart';
import '../components/player.dart';

class MyGame extends FlameGame {
  Player? player;
  JoystickComponent? moveJoystick;
  AttackJoystick? attackJoystick;

  // World is 3x the screen size
  static const double worldScale = 3.0;
  static const double wallThickness = 40;

  late final Vector2 worldSize;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    worldSize = size * worldScale;

    // World — everything in here scrolls with the camera
    final world = World();
    add(world);

    // Camera follows player, shows the world
    final camera = CameraComponent(world: world);
    add(camera);

    // Arena fills the full world size
    final arena = Arena(gameSize: worldSize);
    world.add(arena);

    // Player spawns near bottom-left base area
    player = Player(
      position: Vector2(worldSize.x * 0.15, worldSize.y * 0.8),
      color: const Color(0xFF00CC88),
    );
    world.add(player!);

    // Camera follows player
    camera.follow(player!);

    // Joystick — on HUD so it stays fixed on screen
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
    camera.viewport.add(moveJoystick!);

    // Attack joystick — also on HUD
    attackJoystick = AttackJoystick(
      onAttack: (direction) => player?.attack(direction),
    );
    camera.viewport.add(attackJoystick!);
  }

  @override
  void update(double dt) {
    super.update(dt);

    player?.velocity = moveJoystick?.relativeDelta ?? Vector2.zero();

    // Keep player inside world bounds
    final margin = wallThickness + 16.0;
    player?.position.clamp(
      Vector2(margin, margin),
      Vector2(worldSize.x - margin, worldSize.y - margin),
    );
  }
}
