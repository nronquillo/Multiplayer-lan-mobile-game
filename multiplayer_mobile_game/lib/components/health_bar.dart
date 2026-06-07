import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class HealthBar extends PositionComponent {
  final double maxHp;
  double currentHp;

  static const double barWidth = 60;
  static const double barHeight = 8;

  late final RectangleComponent _background;
  late final RectangleComponent _fill;

  HealthBar({required this.maxHp, required this.currentHp})
    : super(
        position: Vector2(-barWidth / 2, -40),
        size: Vector2(barWidth, barHeight),
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _background = RectangleComponent(
      size: Vector2(barWidth, barHeight),
      paint: Paint()..color = const Color(0xFF333333),
    );
    add(_background);

    _fill = RectangleComponent(
      size: Vector2(barWidth, barHeight),
      paint: Paint()..color = const Color(0xFF00CC44),
    );
    add(_fill);
  }

  void updateHp(double hp) {
    currentHp = hp.clamp(0, maxHp);
    final ratio = currentHp / maxHp;

    // Update width
    _fill.size = Vector2(barWidth * ratio, barHeight);

    // Color shifts green -> yellow -> red
    if (ratio > 0.5) {
      _fill.paint.color = const Color(0xFF00CC44);
    } else if (ratio > 0.25) {
      _fill.paint.color = const Color(0xFFCCAA00);
    } else {
      _fill.paint.color = const Color(0xFFCC2200);
    }
  }
}
