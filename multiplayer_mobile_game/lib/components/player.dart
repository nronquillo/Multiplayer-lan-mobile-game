import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends RectangleComponent {
  static const double speed = 300;
  static const double playerSize = 50;

  Vector2 velocity = Vector2.zero();

  Player({required Vector2 position, required Color color})
    : super(
        position: position,
        size: Vector2.all(playerSize),
        anchor: Anchor.center,
        paint: Paint()..color = color,
      );

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * speed * dt;
  }
}
