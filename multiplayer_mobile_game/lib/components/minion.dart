import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'player.dart';

class Minion extends RectangleComponent with CollisionCallbacks {
  static const double minionSize = 30;
  static const double wanderSpeed = 60;
  static const double chargeSpeed = 140;
  static const double aggroRange = 150;
  static const double damage = 10;
  static const double damageInterval = 1.0;

  final int wave;
  final void Function(Minion minion) onDeath;

  late double _hp;
  late double _maxHp;
  late RectangleComponent _background;
  late RectangleComponent _fill;

  Vector2 _wanderTarget = Vector2.zero();
  double _wanderTimer = 0;
  double _damageTimer = 0;
  bool _isCharging = false;

  final Random _random = Random();

  Minion({required Vector2 position, required this.wave, required this.onDeath})
    : super(
        position: position,
        size: Vector2.all(minionSize),
        anchor: Anchor.center,
        paint: Paint()..color = const Color(0xFFAA4400),
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // HP scales with wave — 1 hit wave 1, more each wave
    _maxHp = wave * 20.0;
    _hp = _maxHp;

    // HP bar background
    _background = RectangleComponent(
      position: Vector2(-minionSize / 2 + minionSize / 2 - 20, -14),
      size: Vector2(40, 5),
      paint: Paint()..color = const Color(0xFF333333),
    );
    add(_background);

    // HP bar fill
    _fill = RectangleComponent(
      position: Vector2(-minionSize / 2 + minionSize / 2 - 20, -14),
      size: Vector2(40, 5),
      paint: Paint()..color = const Color(0xFFCC4400),
    );
    add(_fill);

    add(RectangleHitbox());
    _pickNewWanderTarget();
  }

  void _pickNewWanderTarget() {
    _wanderTarget =
        position +
        Vector2(
          (_random.nextDouble() - 0.5) * 200,
          (_random.nextDouble() - 0.5) * 200,
        );
    _wanderTimer = 2 + _random.nextDouble() * 2;
  }

  Player? _findNearestPlayer() {
    Player? nearest;
    double nearestDist = double.infinity;

    for (final component in parent?.children ?? []) {
      if (component is Player) {
        final dist = position.distanceTo(component.position);
        if (dist < dist && dist < nearestDist) {
          nearestDist = dist;
          nearest = component;
        }
      }
    }
    return nearest;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final nearestPlayer = _findNearestPlayer();

    if (nearestPlayer != null) {
      final dist = position.distanceTo(nearestPlayer.position);
      _isCharging = dist < aggroRange;
    } else {
      _isCharging = false;
    }

    if (_isCharging && nearestPlayer != null) {
      // Charge toward player
      final dir = (nearestPlayer.position - position).normalized();
      position += dir * chargeSpeed * dt;

      // Deal damage if touching
      _damageTimer += dt;
      if (_damageTimer >= damageInterval) {
        _damageTimer = 0;
        final dist = position.distanceTo(nearestPlayer.position);
        if (dist < minionSize + 25) {
          nearestPlayer.takeDamage(damage);
        }
      }
    } else {
      // Wander
      _wanderTimer -= dt;
      if (_wanderTimer <= 0) {
        _pickNewWanderTarget();
      }

      final dir = (_wanderTarget - position);
      if (dir.length > 5) {
        position += dir.normalized() * wanderSpeed * dt;
      }
    }
  }

  void takeDamage(double amount) {
    _hp = (_hp - amount).clamp(0, _maxHp);
    _fill.size = Vector2(40 * (_hp / _maxHp), 5);

    if (_hp <= 0) {
      onDeath(this);
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
  }
}
