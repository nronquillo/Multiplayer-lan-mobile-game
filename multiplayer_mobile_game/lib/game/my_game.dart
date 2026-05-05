import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../components/arena.dart';
import '../components/attack_joystick.dart';
import '../components/player.dart';

class MyGame extends FlameGame with HasCollisionDetection {
  Player? player1;
  Player? player2;
  JoystickComponent? moveJoystick1;
  JoystickComponent? moveJoystick2;
  AttackJoystick? attackJoystick1;
  AttackJoystick? attackJoystick2;

  static const double worldScale = 3.0;
  static const double wallThickness = 40;

  late final Vector2 worldSize;
  bool gameOver = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    worldSize = size * worldScale;

    final world = World();
    add(world);

    final camera = CameraComponent(world: world);
    add(camera);

    world.add(Arena(gameSize: worldSize));

    player1 = Player(
      playerId: 1,
      position: Vector2(worldSize.x * 0.15, worldSize.y * 0.8),
      color: const Color(0xFF00CC88),
      onDeath: (id) => _handleDeath(id),
    );
    world.add(player1!);

    player2 = Player(
      playerId: 2,
      position: Vector2(worldSize.x * 0.15, worldSize.y * 0.8),
      color: const Color(0xFFCC3300),
      onDeath: (id) => _handleDeath(id),
    );
    world.add(player2!);

    camera.follow(player1!);

    moveJoystick1 = JoystickComponent(
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
    camera.viewport.add(moveJoystick1!);

    attackJoystick1 = AttackJoystick(
      onAttack: (dir) => player1?.attack(dir),
      margin: const EdgeInsets.only(right: 50, bottom: 60),
    );
    camera.viewport.add(attackJoystick1!);

    moveJoystick2 = JoystickComponent(
      knob: CircleComponent(
        radius: 30,
        paint: Paint()..color = const Color(0xAAFFFFFF),
      ),
      background: CircleComponent(
        radius: 70,
        paint: Paint()..color = const Color(0x55FFFFFF),
      ),
      margin: const EdgeInsets.only(right: 40, top: 60),
    );
    camera.viewport.add(moveJoystick2!);

    attackJoystick2 = AttackJoystick(
      onAttack: (dir) => player2?.attack(dir),
      margin: const EdgeInsets.only(left: 50, top: 60),
      knobPaint: Paint()..color = const Color(0xAACC3300),
      backgroundPaint: Paint()..color = const Color(0x55CC3300),
    );
    camera.viewport.add(attackJoystick2!);
  }

  void _handleDeath(int loserId) {
    if (gameOver) return;
    gameOver = true;

    final winnerId = loserId == 1 ? 2 : 1;
    overlays.add('winner_$winnerId');

    // Stop movement
    player1?.velocity = Vector2.zero();
    player2?.velocity = Vector2.zero();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameOver) return;

    player1?.velocity = moveJoystick1?.relativeDelta ?? Vector2.zero();
    player2?.velocity = moveJoystick2?.relativeDelta ?? Vector2.zero();

    final margin = wallThickness + 16.0;
    player1?.position.clamp(
      Vector2(margin, margin),
      Vector2(worldSize.x - margin, worldSize.y - margin),
    );
    player2?.position.clamp(
      Vector2(margin, margin),
      Vector2(worldSize.x - margin, worldSize.y - margin),
    );
  }
}
