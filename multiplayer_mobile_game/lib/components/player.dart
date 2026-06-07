import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'sword.dart';

class Player extends PositionComponent with CollisionCallbacks {
  static const double playerSize = 50;

  final int playerId;
  final void Function(int loserId)? onDeath;
  final Color color;
  final double baseSpeed;
  final double baseDamage;

  Vector2 velocity = Vector2.zero();
  bool _isAttacking = false;
  double hp = 100;
  double maxHp = 100;

  late final RectangleComponent _background;
  late final RectangleComponent _fill;

  Player({
    required this.playerId,
    required Vector2 position,
    required this.color,
    required double baseHp,
    required this.baseSpeed,
    required this.baseDamage,
    this.onDeath,
  }) : super(
         position: position,
         size: Vector2.all(playerSize),
         anchor: Anchor.center,
       ) {
    hp = baseHp;
    maxHp = baseHp;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _background = RectangleComponent(
      size: Vector2.all(playerSize),
      paint: Paint()..color = color.withOpacity(0.2),
    );
    add(_background);

    _fill = RectangleComponent(
      position: Vector2.zero(),
      size: Vector2.all(playerSize),
      paint: Paint()..color = color,
    );
    add(_fill);

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * baseSpeed * dt;
  }

  void attack(Vector2 direction) {
    if (_isAttacking) return;
    _isAttacking = true;

    parent?.add(
      Sword(
        ownerPlayerId: playerId,
        playerPosition: position,
        direction: direction,
        damage: baseDamage,
      ),
    );

    Future.delayed(
      const Duration(milliseconds: 300),
      () => _isAttacking = false,
    );
  }

  void takeDamage(double amount) {
    hp = (hp - amount).clamp(0, maxHp);
    _updateFill();

    if (hp <= 0) {
      onDeath?.call(playerId);
    }
  }

  void _updateFill() {
    final ratio = hp / maxHp;
    final fillHeight = playerSize * ratio;
    _fill.size = Vector2(playerSize, fillHeight);
    _fill.position = Vector2(0, playerSize - fillHeight);
  }

  bool get isDead => hp <= 0;
}
