import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'player.dart';
import 'minion.dart';

class Sword extends RectangleComponent with CollisionCallbacks {
  static const double swingDuration = 0.3;
  final double damage;

  final int ownerPlayerId;
  double _timer = 0;

  Sword({
    required this.ownerPlayerId,
    required Vector2 playerPosition,
    required Vector2 direction,
    this.damage = 20, // default fallback
  }) : super(
         position: playerPosition + direction * 30,
         size: Vector2(44, 16),
         anchor: Anchor.centerLeft,
         angle: atan2(direction.y, direction.x),
         paint: Paint()..color = const Color(0xAAC0C0C0),
       );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer += dt;
    if (_timer >= swingDuration) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Player) {
      // Minion sword hits any player, player sword only hits opponent
      if (ownerPlayerId == -1 || other.playerId != ownerPlayerId) {
        other.takeDamage(damage);
        removeFromParent();
      }
    }

    if (other is Minion) {
      other.takeDamage(damage);
      removeFromParent();
    }
  }
}
