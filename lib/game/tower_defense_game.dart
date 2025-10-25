import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'enemy.dart';
import 'tower.dart';
import 'wave_manager.dart';

/// Class utama yang mengelola state dan logika game Tower Defense.
class TowerDefenseGame extends FlameGame with HasCollisionDetection, HasTappables {
  late WaveManager waveManager;
  final ValueNotifier<int> livesNotifier = ValueNotifier(10);
  final ValueNotifier<int> coinsNotifier = ValueNotifier(100);
  final ValueNotifier<int> scoreNotifier = ValueNotifier(0);

  // Callback untuk navigasi ke layar GameOver, membawa skor akhir
  final Function(int) onGameOver;

  TowerDefenseGame({required this.onGameOver});

  @override
  Color backgroundColor() => const Color(0xFF2E7D32); // Menggunakan warna dari constants

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Muat dan putar musik latar dengan penanganan error
    try {
      await FlameAudio.bgm.load('background_music.mp3');
      FlameAudio.bgm.play('background_music.mp3');
    } catch (e) {
      print("Error loading background music: $e");
    }

    // Set resolusi kamera
    camera.viewport = FixedResolutionViewport(resolution: Vector2(gameWidth, gameHeight));

    // Tambahkan path untuk musuh berjalan
    _addPath();

    // Inisialisasi wave manager
    waveManager = WaveManager(game: this);
    add(waveManager);
  }

  // Dipanggil ketika musuh mencapai base
  void enemyReachedBase(Enemy enemy) {
    livesNotifier.value--;
    enemy.removeFromParent();

    if (livesNotifier.value <= 0) {
      onGameOver(scoreNotifier.value);
    }
  }

  // Dipanggil ketika musuh dikalahkan
  void enemyDefeated(Enemy enemy) {
    coinsNotifier.value += 10;
    scoreNotifier.value += 5; // Tambah 5 poin per musuh
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    _placeTower(info.eventPosition.game);
  }

  void _placeTower(Vector2 position) {
    const towerCost = 50;
    // Cek apakah pemain punya cukup koin
    if (coinsNotifier.value >= towerCost) {
      // Cek apakah lokasi penempatan valid (tidak di jalur)
      final pathRect = Rect.fromLTWH(0, gameHeight / 2 - 20, gameWidth, 40);
      if (!pathRect.contains(position.toOffset())) {
        coinsNotifier.value -= towerCost;
        add(Tower(position: position));
      } else {
        print("Tidak bisa menempatkan menara di jalur!");
      }
    } else {
      print("Koin tidak cukup!");
    }
  }

  // Menggambar jalur tempat musuh berjalan
  void _addPath() {
    final path = Path()
      ..moveTo(0, gameHeight / 2)
      ..lineTo(gameWidth, gameHeight / 2);

    final pathComponent = PathComponent(
      path: path,
      paint: Paint()
        ..color = pathColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 40.0,
    );
    add(pathComponent);
  }
}

// Komponen untuk menggambar path (jalur)
class PathComponent extends Component {
  final Path path;
  final Paint paint;

  PathComponent({required this.path, required this.paint});

  @override
  void render(Canvas canvas) {
    canvas.drawPath(path, paint);
  }
}
