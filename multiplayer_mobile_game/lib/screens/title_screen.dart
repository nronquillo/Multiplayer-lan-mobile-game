import 'package:flutter/material.dart';

class TitleScreen extends StatefulWidget {
  final VoidCallback onPlay;

  const TitleScreen({super.key, required this.onPlay});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [_buildTorch(), _buildTorch()],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'DUNGEON',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFCC44),
                      letterSpacing: 12,
                      shadows: [
                        Shadow(color: const Color(0xFFFF6600), blurRadius: 20),
                      ],
                    ),
                  ),
                  Text(
                    'DUEL',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 16,
                      shadows: [
                        Shadow(color: const Color(0xFFFFCC44), blurRadius: 30),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  AnimatedBuilder(
                    animation: _glowAnimation,
                    builder: (context, child) {
                      return GestureDetector(
                        onTap: widget.onPlay,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A2E),
                            border: Border.all(
                              color: const Color(0xFFFFCC44),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFFFF6600,
                                ).withOpacity(_glowAnimation.value),
                                blurRadius: 30,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: const Text(
                            'PLAY',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFCC44),
                              letterSpacing: 8,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      7,
                      (i) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A2A1A),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
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

  Widget _buildTorch() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Column(
          children: [
            Container(
              width: 12,
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFF6B4226),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFFFF6600,
                    ).withOpacity(_glowAnimation.value * 0.8),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF6600),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFFFF6600,
                    ).withOpacity(_glowAnimation.value),
                    blurRadius: 24,
                    spreadRadius: 6,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
