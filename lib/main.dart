import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/tower_defense_game.dart';
import 'ui/main_menu.dart';
import 'ui/game_over_screen.dart';
import 'ui/hud.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tower Defense',
      theme: ThemeData.dark(),
      // Sediakan rute untuk navigasi antar layar
      routes: {
        '/': (context) => const MainMenu(),
        '/game': (context) => GameScreen(),
        '/gameover': (context) => const GameOverScreen(),
      },
      initialRoute: '/',
    );
  }
}

// Widget yang akan menampung layar game utama
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final TowerDefenseGame _game;

  @override
  void initState() {
    super.initState();
    _game = TowerDefenseGame(onGameOver: _onGameOver);
  }

  void _onGameOver(int score) {
    // Navigasi ke layar game over dan kirim skor
    Navigator.pushReplacementNamed(
      context,
      '/gameover',
      arguments: score,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: _game,
        overlayBuilderMap: {
          'Hud': (context, game) => Hud(game: _game),
        },
        initialActiveOverlays: const ['Hud'],
      ),
    );
  }
}
