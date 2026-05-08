import 'dart:math';
import 'package:flame/components.dart';
import 'minion.dart';

class MinionSpawner extends Component {
  static const int maxMinions = 5;
  static const double respawnTime = 10.0;

  final Vector2 spawnCenter;
  final double spawnRadius;
  final int Function() getCurrentWave;
  final void Function(int gold) onMinionKilled;

  int _aliveCount = 0;
  double _respawnTimer = 0;
  bool _waitingToRespawn = false;
  final Random _random = Random();

  MinionSpawner({
    required this.spawnCenter,
    required this.spawnRadius,
    required this.getCurrentWave,
    required this.onMinionKilled,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _spawnWave();
  }

  void _spawnWave() {
    _aliveCount = maxMinions;
    _waitingToRespawn = false;
    _respawnTimer = 0;

    for (int i = 0; i < maxMinions; i++) {
      final offset = Vector2(
        (_random.nextDouble() - 0.5) * spawnRadius * 2,
        (_random.nextDouble() - 0.5) * spawnRadius * 2,
      );

      final minion = Minion(
        position: spawnCenter + offset,
        wave: getCurrentWave(),
        onDeath: _onMinionDied,
      );

      parent?.add(minion);
    }
  }

  void _onMinionDied(Minion minion) {
    _aliveCount--;
    onMinionKilled(10); // 10 gold per minion

    if (_aliveCount <= 0) {
      _waitingToRespawn = true;
      _respawnTimer = respawnTime;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_waitingToRespawn) {
      _respawnTimer -= dt;
      if (_respawnTimer <= 0) {
        _spawnWave();
      }
    }
  }
}
