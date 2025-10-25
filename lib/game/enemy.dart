import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import '../utils/constants.dart';
import 'tower_defense_game.dart';
import 'explosion_effect.dart';

/// Class yang merepresentasikan musuh dalam game.
class Enemy extends PositionComponent with HasGameRef<TowerDefenseGame> {
  double hp;
  double speed;
  late Vector2 velocity;

  Enemy({
    required Vector2 position,
    this.hp = 100,
    this.speed = 50,
  }) : super(
          position: position,
          size: Vector2.all(30), // Ukuran musuh 30x30
          anchor: Anchor.center,
        );

  @override
  void onLoad() {
    super.onLoad();
    // Musuh bergerak dari kiri ke kanan
    velocity = Vector2(speed, 0);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Perbarui posisi berdasarkan kecepatan
    position += velocity * dt;

    // Jika musuh keluar layar di sebelah kanan
    if (position.x > gameRef.size.x) {
      gameRef.enemyReachedBase(this);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Gambar placeholder musuh (kotak merah)
    canvas.drawRect(size.toRect(), Paint()..color = enemyColor);
  }

  // Fungsi untuk menerima damage
  void takeDamage(double damage) {
    hp -= damage;
    if (hp <= 0) {
      // Tambahkan efek ledakan visual
      gameRef.add(ExplosionEffect(position: position));

      // Putar suara ledakan dengan penanganan error
      try {
        FlameAudio.play('explosion.wav');
      } catch (e) {
        print("Error playing explosion sound: $e");
      }

      gameRef.enemyDefeated(this);
      removeFromParent(); // Hapus musuh jika HP habis
    }
  }
}
