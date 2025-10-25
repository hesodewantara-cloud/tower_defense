import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Layar menu utama game.
class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Latar belakang placeholder (bisa diganti gambar galaksi)
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey, Colors.black],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Tower Defense',
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 20.0, color: Colors.blue)],
                ),
              ),
              const SizedBox(height: 50.0),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke layar game
                    Navigator.pushReplacementNamed(context, '/game');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: const Text('Play', style: TextStyle(fontSize: 20.0)),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Keluar dari aplikasi
                    SystemNavigator.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                     backgroundColor: Colors.redAccent,
                  ),
                  child: const Text('Exit', style: TextStyle(fontSize: 20.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
