import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Arena extends Component {
  static const double wallThickness = 40;

  late final Vector2 gameSize;

  Arena({required this.gameSize});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Floor
    add(
      RectangleComponent(
        position: Vector2(wallThickness, wallThickness),
        size: Vector2(
          gameSize.x - wallThickness * 2,
          gameSize.y - wallThickness * 2,
        ),
        paint: Paint()..color = const Color(0xFF1E1E35),
      ),
    );

    // Walls
    _addWall(Vector2.zero(), Vector2(gameSize.x, wallThickness)); // top
    _addWall(
      Vector2(0, gameSize.y - wallThickness),
      Vector2(gameSize.x, wallThickness),
    ); // bottom
    _addWall(Vector2.zero(), Vector2(wallThickness, gameSize.y)); // left
    _addWall(
      Vector2(gameSize.x - wallThickness, 0),
      Vector2(wallThickness, gameSize.y),
    ); // right

    // Pillars
    final pillarSize = Vector2(28, 28);
    final inset = wallThickness + 8.0;
    _addPillar(Vector2(inset, inset), pillarSize);
    _addPillar(Vector2(gameSize.x - inset - pillarSize.x, inset), pillarSize);
    _addPillar(Vector2(inset, gameSize.y - inset - pillarSize.y), pillarSize);
    _addPillar(
      Vector2(
        gameSize.x - inset - pillarSize.x,
        gameSize.y - inset - pillarSize.y,
      ),
      pillarSize,
    );

    // Torches
    _addTorch(Vector2(inset + 2, inset - 10));
    _addTorch(Vector2(gameSize.x - inset - 10, inset - 10));
    _addTorch(Vector2(inset + 2, gameSize.y - inset + 2));
    _addTorch(Vector2(gameSize.x - inset - 10, gameSize.y - inset + 2));
  }

  void _addWall(Vector2 position, Vector2 size) {
    add(
      RectangleComponent(
        position: position,
        size: size,
        paint: Paint()..color = const Color(0xFF3A2A1A),
      ),
    );
  }

  void _addPillar(Vector2 position, Vector2 size) {
    add(
      RectangleComponent(
        position: position,
        size: size,
        paint: Paint()..color = const Color(0xFF2E2215),
      ),
    );
    add(
      RectangleComponent(
        position: position + Vector2(3, 3),
        size: size - Vector2(6, 6),
        paint: Paint()..color = const Color(0xFF3D2E1A),
      ),
    );
  }

  void _addTorch(Vector2 position) {
    // Glow
    add(
      CircleComponent(
        position: position,
        radius: 18,
        anchor: Anchor.center,
        paint: Paint()..color = const Color(0x18FF6600),
      ),
    );
    // Flame
    add(
      CircleComponent(
        position: position,
        radius: 6,
        anchor: Anchor.center,
        paint: Paint()..color = const Color(0xFFFF6600),
      ),
    );
    // Bright center
    add(
      CircleComponent(
        position: position,
        radius: 3,
        anchor: Anchor.center,
        paint: Paint()..color = const Color(0xFFFFCC00),
      ),
    );
  }
}
