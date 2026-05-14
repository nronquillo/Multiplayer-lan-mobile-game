enum ClassType { tank, ranger, farmer, assassin, fighter, witch }

class PlayerClass {
  final ClassType type;
  final String name;
  final String description;
  final String weaponDescription;
  final double baseHp;
  final double baseSpeed;
  final double baseDamage;
  final double hpScaling;
  final double speedScaling;
  final double damageScaling;
  final int color;
  final String emoji;

  const PlayerClass({
    required this.type,
    required this.name,
    required this.description,
    required this.weaponDescription,
    required this.baseHp,
    required this.baseSpeed,
    required this.baseDamage,
    required this.hpScaling,
    required this.speedScaling,
    required this.damageScaling,
    required this.color,
    required this.emoji,
  });

  static const tank = PlayerClass(
    type: ClassType.tank,
    name: 'TANK',
    description: 'Absorbs punishment and outlasts enemies.',
    weaponDescription: 'Sword — close range, low damage',
    baseHp: 200,
    baseSpeed: 180,
    baseDamage: 15,
    hpScaling: 2.0,
    speedScaling: 0.5,
    damageScaling: 0.75,
    color: 0xFF4488FF,
    emoji: '🛡️',
  );

  static const ranger = PlayerClass(
    type: ClassType.ranger,
    name: 'RANGER',
    description: 'Keeps distance and picks enemies off.',
    weaponDescription: 'Bow — ranged projectile',
    baseHp: 100,
    baseSpeed: 280,
    baseDamage: 25,
    hpScaling: 0.75,
    speedScaling: 2.0,
    damageScaling: 2.0,
    color: 0xFF44CC44,
    emoji: '🏹',
  );

  static const farmer = PlayerClass(
    type: ClassType.farmer,
    name: 'FARMER',
    description: 'Clears minion camps fast. Steady and reliable.',
    weaponDescription: 'Scythe — wide AOE swing',
    baseHp: 120,
    baseSpeed: 240,
    baseDamage: 20,
    hpScaling: 1.0,
    speedScaling: 1.0,
    damageScaling: 1.0,
    color: 0xFFCCAA00,
    emoji: '🌾',
  );

  static const assassin = PlayerClass(
    type: ClassType.assassin,
    name: 'ASSASSIN',
    description: 'Extremely fast. Weak early, devastating late.',
    weaponDescription: 'Dagger — very close range, fast',
    baseHp: 80,
    baseSpeed: 400,
    baseDamage: 10,
    hpScaling: 0.5,
    speedScaling: 1.5,
    damageScaling: 3.0,
    color: 0xFFAA00AA,
    emoji: '🗡️',
  );

  static const fighter = PlayerClass(
    type: ClassType.fighter,
    name: 'FIGHTER',
    description: 'Excellent base stats. Peaks early.',
    weaponDescription: 'Sword — balanced, close range',
    baseHp: 150,
    baseSpeed: 320,
    baseDamage: 30,
    hpScaling: 0.5,
    speedScaling: 0.5,
    damageScaling: 0.5,
    color: 0xFFFF6600,
    emoji: '⚔️',
  );

  static const witch = PlayerClass(
    type: ClassType.witch,
    name: 'WITCH',
    description: 'Converts minions into weapons against the enemy.',
    weaponDescription: 'Staff — minion control',
    baseHp: 100,
    baseSpeed: 260,
    baseDamage: 12,
    hpScaling: 0.75,
    speedScaling: 1.0,
    damageScaling: 1.5,
    color: 0xFF880088,
    emoji: '🔮',
  );

  static const List<PlayerClass> all = [
    tank,
    ranger,
    farmer,
    assassin,
    fighter,
    witch,
  ];
}
