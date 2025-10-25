import 'package:flutter/material.dart';
import '../game/tower_defense_game.dart';

/// Widget yang menampilkan informasi game (HUD).
class Hud extends StatelessWidget {
  final TowerDefenseGame game;

  const Hud({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tampilan Nyawa
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ValueListenableBuilder<int>(
              valueListenable: game.livesNotifier,
              builder: (context, lives, child) {
                return Text(
                  'Lives: $lives',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                );
              },
            ),
          ),
          // Tampilan Koin
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ValueListenableBuilder<int>(
              valueListenable: game.coinsNotifier,
              builder: (context, coins, child) {
                return Text(
                  'Coins: $coins',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
