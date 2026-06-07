import 'package:flutter/material.dart';
import '../models/player_class.dart';

class ClassSelectScreen extends StatefulWidget {
  final int playerNumber;
  final void Function(PlayerClass selected) onConfirm;

  const ClassSelectScreen({
    super.key,
    required this.playerNumber,
    required this.onConfirm,
  });

  @override
  State<ClassSelectScreen> createState() => _ClassSelectScreenState();
}

class _ClassSelectScreenState extends State<ClassSelectScreen> {
  PlayerClass? _selected;

  @override
  Widget build(BuildContext context) {
    final playerColor = widget.playerNumber == 1
        ? const Color(0xFF00CC88)
        : const Color(0xFFCC3300);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0D0D1A), Color(0xFF1A1A2E)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Header
            Text(
              'PLAYER ${widget.playerNumber}',
              style: TextStyle(
                fontSize: 11,
                color: playerColor,
                letterSpacing: 6,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'CHOOSE YOUR CLASS',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFFFCC44),
                letterSpacing: 6,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Color(0xFFFF6600), blurRadius: 12)],
              ),
            ),

            const SizedBox(height: 12),

            // Class grid — 3 columns, no scroll
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2.8,
                physics: const NeverScrollableScrollPhysics(),
                children: PlayerClass.all
                    .map((pc) => _buildClassCard(pc))
                    .toList(),
              ),
            ),

            // Confirm button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: GestureDetector(
                onTap: _selected == null
                    ? null
                    : () => widget.onConfirm(_selected!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: _selected == null
                        ? const Color(0xFF111120)
                        : const Color(0xFF1A1A2E),
                    border: Border.all(
                      color: _selected == null
                          ? const Color(0xFF333344)
                          : const Color(0xFFFFCC44),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: _selected == null
                        ? []
                        : [
                            const BoxShadow(
                              color: Color(0x44FF6600),
                              blurRadius: 16,
                              spreadRadius: 2,
                            ),
                          ],
                  ),
                  child: Text(
                    _selected == null ? 'SELECT A CLASS' : 'CONFIRM',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 6,
                      color: _selected == null
                          ? const Color(0xFF444455)
                          : const Color(0xFFFFCC44),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard(PlayerClass pc) {
    final isSelected = _selected?.type == pc.type;
    final classColor = Color(pc.color);

    return GestureDetector(
      onTap: () => setState(() => _selected = pc),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected
              ? classColor.withOpacity(0.15)
              : const Color(0xFF111120),
          border: Border.all(
            color: isSelected ? classColor : const Color(0xFF2A2A3A),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: classColor.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Emoji + name
            Row(
              children: [
                Text(pc.emoji, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    pc.name,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: classColor,
                      letterSpacing: 1,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Description
            Text(
              pc.description,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF888899),
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            // Weapon
            Text(
              pc.weaponDescription,
              style: const TextStyle(
                fontSize: 8,
                color: Color(0xFF666677),
                fontStyle: FontStyle.italic,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // Stat bars
            Column(
              children: [
                _statBar('HP', pc.baseHp / 200, const Color(0xFF00CC44)),
                const SizedBox(height: 3),
                _statBar('SPD', pc.baseSpeed / 400, const Color(0xFF44AAFF)),
                const SizedBox(height: 3),
                _statBar('DMG', pc.baseDamage / 30, const Color(0xFFFF4444)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBar(String label, double ratio, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 8,
              color: Color(0xFF666677),
              letterSpacing: 1,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Stack(
              children: [
                Container(height: 3, color: const Color(0xFF222233)),
                FractionallySizedBox(
                  widthFactor: ratio.clamp(0, 1),
                  child: Container(height: 3, color: color),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
