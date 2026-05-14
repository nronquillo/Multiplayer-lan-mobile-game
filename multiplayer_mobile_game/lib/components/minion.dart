import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'player.dart';
import 'sword.dart';

class Minion extends PositionComponent with CollisionCallbacks {
  static const double minionSize = 30;
  static const double wanderSpeed = 60;
  static const double chargeSpeed = 140;
  static const double aggroRange = 150;
  static const double attackRange = 55;
  static const double attackCooldown = 1.2;

  static const Color minionColor = Color(0xFFAA4400);

  final int wave;
  final void Function(Minion minion) onDeath;

  late double _hp;
  late double _maxHp;
  late RectangleComponent _background;
  late RectangleComponent _fill;

  Vector2 _wanderTarget = Vector2.zero();
  double _wanderTimer = 0;
  double _attackTimer = 0;
  bool _isCharging = false;

  final Random _random = Random();

  Minion({required Vector2 position, required this.wave, required this.onDeath})
    : super(
        position: position,
        size: Vector2.all(minionSize),
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _maxHp = wave * 20.0;
    _hp = _maxHp;

    _background = RectangleComponent(
      size: Vector2.all(minionSize),
      paint: Paint()..color = minionColor.withOpacity(0.2),
    );
    add(_background);

    _fill = RectangleComponent(
      position: Vector2.zero(),
      size: Vector2.all(minionSize),
      paint: Paint()..color = minionColor,
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
        if (dist < nearestDist) {
          nearestDist = dist;
          nearest = component;
        }
      }
    }
    return nearest;
  }

  void _swingAt(Player target) {
    final dir = (target.position - position).normalized();
    parent?.add(
      Sword(
        ownerPlayerId: -1, // -1 = minion owned, hits any player
        playerPosition: position,
        direction: dir,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    _attackTimer += dt;

    final nearestPlayer = _findNearestPlayer();

    if (nearestPlayer != null) {
      final dist = position.distanceTo(nearestPlayer.position);
      _isCharging = dist < aggroRange;

      if (_isCharging) {
        if (dist > attackRange) {
          // Move toward player but stop at attack range
          final dir = (nearestPlayer.position - position).normalized();
          position += dir * chargeSpeed * dt;
        } else {
          // In attack range — swing on cooldown
          if (_attackTimer >= attackCooldown) {
            _attackTimer = 0;
            _swingAt(nearestPlayer);
          }
        }
      }
    } else {
      _isCharging = false;
    }

    if (!_isCharging) {
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
    _updateFill();
    if (_hp <= 0) {
      onDeath(this);
      removeFromParent();
    }
  }

  void _updateFill() {
    final ratio = _hp / _maxHp;
    final fillHeight = minionSize * ratio;
    _fill.size = Vector2(minionSize, fillHeight);
    _fill.position = Vector2(0, minionSize - fillHeight);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
  }
}
