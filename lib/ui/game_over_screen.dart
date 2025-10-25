import 'package:flutter/material.dart';

/// Layar yang ditampilkan saat pemain kalah.
class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil skor dari arguments rute
    final score = ModalRoute.of(context)!.settings.arguments as int? ?? 0;

    return Scaffold(
      body: Container(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Game Over',
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Final Score: $score',
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50.0),
              // Tombol untuk memulai game kembali
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/game');
                  },
                  child: const Text('Restart'),
                ),
              ),
              const SizedBox(height: 20.0),
              // Tombol untuk kembali ke menu utama
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text('Main Menu'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
