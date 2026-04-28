import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class AttackJoystick extends JoystickComponent {
  final void Function(Vector2 direction) onAttack;
  bool _wasActive = false;
  Vector2 _lastDirection = Vector2.zero();

  AttackJoystick({required this.onAttack})
    : super(
        knob: CircleComponent(
          radius: 30,
          paint: Paint()..color = const Color(0xAACC3300),
        ),
        background: CircleComponent(
          radius: 70,
          paint: Paint()..color = const Color(0x55CC3300),
        ),
        margin: const EdgeInsets.only(right: 50, bottom: 60),
      );

  @override
  void update(double dt) {
    super.update(dt);

    final isActive = !relativeDelta.isZero();

    if (isActive) {
      _wasActive = true;
      _lastDirection = relativeDelta.normalized();
    } else if (_wasActive) {
      // Just released — fire attack
      onAttack(_lastDirection);
      _wasActive = false;
      _lastDirection = Vector2.zero();
    }
  }
}
