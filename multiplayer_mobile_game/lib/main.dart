import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game/my_game.dart';
import 'screens/title_screen.dart';
import 'screens/mode_select.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DungeonDuelApp());
}

class DungeonDuelApp extends StatefulWidget {
  const DungeonDuelApp({super.key});

  @override
  State<DungeonDuelApp> createState() => _DungeonDuelAppState();
}

class _DungeonDuelAppState extends State<DungeonDuelApp> {
  String _screen = 'title'; // title, mode_select, game
  MyGame? _game;

  void _startGame() {
    setState(() {
      _game = MyGame();
      _screen = 'game';
    });
  }

  void _restart() {
    setState(() {
      _game = MyGame();
      _screen = 'title';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: _buildScreen()),
    );
  }

  Widget _buildScreen() {
    switch (_screen) {
      case 'title':
        return TitleScreen(
          onPlay: () => setState(() => _screen = 'mode_select'),
        );
      case 'mode_select':
        return ModeSelectScreen(
          on1v1: _startGame,
          onBack: () => setState(() => _screen = 'title'),
        );
      case 'game':
        return GameWidget(
          game: _game!,
          overlayBuilderMap: {
            'winner_1': (context, game) =>
                _winScreen('Player 1 Wins! 🏆', Colors.green),
            'winner_2': (context, game) =>
                _winScreen('Player 2 Wins! 🏆', Colors.red),
          },
        );
      default:
        return const SizedBox();
    }
  }

  Widget _winScreen(String message, Color color) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(
                color: color,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _restart,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  border: Border.all(color: const Color(0xFFFFCC44), width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'MAIN MENU',
                  style: TextStyle(
                    color: Color(0xFFFFCC44),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
