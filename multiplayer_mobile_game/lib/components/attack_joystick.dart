import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class AttackJoystick extends JoystickComponent {
  final void Function(Vector2 direction) onAttack;
  bool _wasActive = false;
  Vector2 _lastDirection = Vector2.zero();

  AttackJoystick({
    required this.onAttack,
    EdgeInsets margin = const EdgeInsets.only(right: 50, bottom: 60),
    Paint? knobPaint,
    Paint? backgroundPaint,
  }) : super(
         knob: CircleComponent(
           radius: 30,
           paint: knobPaint ?? (Paint()..color = const Color(0xAACC3300)),
         ),
         background: CircleComponent(
           radius: 70,
           paint: backgroundPaint ?? (Paint()..color = const Color(0x55CC3300)),
         ),
         margin: margin,
       );

  @override
  void update(double dt) {
    super.update(dt);

    final isActive = !relativeDelta.isZero();

    if (isActive) {
      _wasActive = true;
      _lastDirection = relativeDelta.normalized();
    } else if (_wasActive) {
      onAttack(_lastDirection);
      _wasActive = false;
      _lastDirection = Vector2.zero();
    }
  }
}
