import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game/my_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final game = MyGame();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(
          game: game,
          overlayBuilderMap: {
            'winner_1': (context, game) =>
                _winScreen('Player 1 Wins! 🏆', Colors.green),
            'winner_2': (context, game) =>
                _winScreen('Player 2 Wins! 🏆', Colors.red),
          },
        ),
      ),
    ),
  );
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
          const SizedBox(height: 16),
          Text(
            'Restart to play again',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    ),
  );
}
