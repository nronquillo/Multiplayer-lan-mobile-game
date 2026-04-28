import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Sword extends RectangleComponent {
  static const double swingDuration = 0.3;
  double _timer = 0;

  Sword({required Vector2 playerPosition, required Vector2 direction})
    : super(
        position: playerPosition + direction * 30,
        size: Vector2(44, 16),
        anchor: Anchor.centerLeft,
        angle: atan2(direction.y, direction.x),
        paint: Paint()..color = const Color(0xAAC0C0C0),
      );

  @override
  void update(double dt) {
    super.update(dt);
    _timer += dt;
    if (_timer >= swingDuration) {
      removeFromParent();
    }
  }
}
