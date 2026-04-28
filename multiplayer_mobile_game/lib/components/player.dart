import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Player extends RectangleComponent with DragCallbacks {
  static const double speed = 300;
  static const double playerSize = 50;

  Player({required Vector2 position, required Color color})
    : super(
        position: position,
        size: Vector2.all(playerSize),
        anchor: Anchor.center,
        paint: Paint()..color = color,
      );

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;
  }
}
