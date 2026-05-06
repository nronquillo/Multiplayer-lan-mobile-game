import 'package:flutter/material.dart';

class ModeSelectScreen extends StatelessWidget {
  final VoidCallback on1v1;
  final VoidCallback onBack;

  const ModeSelectScreen({
    super.key,
    required this.on1v1,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0D0D1A), Color(0xFF1A1A2E)],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'SELECT MODE',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFCC44),
                      letterSpacing: 8,
                      shadows: [
                        Shadow(color: Color(0xFFFF6600), blurRadius: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildMenuButton(
                    label: '1V1',
                    subtitle: 'Local Duel',
                    onTap: on1v1,
                    enabled: true,
                  ),
                  const SizedBox(height: 16),
                  _buildMenuButton(
                    label: '2V2',
                    subtitle: 'Coming Soon',
                    onTap: null,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  _buildMenuButton(
                    label: 'SETTINGS',
                    subtitle: 'Coming Soon',
                    onTap: null,
                    enabled: false,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: onBack,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF888888),
                          size: 14,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'BACK',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF888888),
                            letterSpacing: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required String label,
    required String subtitle,
    required VoidCallback? onTap,
    required bool enabled,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFF1A1A2E) : const Color(0xFF111120),
          border: Border.all(
            color: enabled ? const Color(0xFF3A2A1A) : const Color(0xFF222233),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: enabled ? Colors.white : const Color(0xFF444455),
                letterSpacing: 6,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: enabled
                    ? const Color(0xFF888888)
                    : const Color(0xFF333344),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
