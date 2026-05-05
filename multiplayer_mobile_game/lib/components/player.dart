import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'sword.dart';
import 'health_bar.dart';
import 'package:flame/collisions.dart';

class Player extends RectangleComponent {
  static const double speed = 300;
  static const double playerSize = 50;

  final int playerId;
  final void Function(int loserId)? onDeath;
  Vector2 velocity = Vector2.zero();
  bool _isAttacking = false;
  double hp = 100;
  double maxHp = 100;
  late final HealthBar _healthBar;

  Player({
    required this.playerId,
    required Vector2 position,
    required Color color,
    this.onDeath,
  }) : super(
         position: position,
         size: Vector2.all(playerSize),
         anchor: Anchor.center,
         paint: Paint()..color = color,
       );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _healthBar = HealthBar(maxHp: maxHp, currentHp: hp);
    add(_healthBar);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * speed * dt;
  }

  void attack(Vector2 direction) {
    if (_isAttacking) return;
    _isAttacking = true;

    parent?.add(
      Sword(
        ownerPlayerId: playerId,
        playerPosition: position,
        direction: direction,
      ),
    );

    Future.delayed(
      const Duration(milliseconds: 300),
      () => _isAttacking = false,
    );
  }

  void takeDamage(double amount) {
    hp = (hp - amount).clamp(0, maxHp);
    _healthBar.updateHp(hp);

    if (hp <= 0) {
      onDeath?.call(playerId);
    }
  }

  bool get isDead => hp <= 0;
}
