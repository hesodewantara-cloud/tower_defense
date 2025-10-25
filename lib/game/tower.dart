import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import '../utils/constants.dart';
import 'enemy.dart';
import 'bullet.dart';
import 'tower_defense_game.dart';

/// Class yang merepresentasikan menara pertahanan.
class Tower extends PositionComponent with HasGameRef<TowerDefenseGame> {
  final double range = 150.0; // Jangkauan menara
  final double fireRate = 1.0; // Tembakan per detik
  double _fireCooldown = 0;

  Tower({required Vector2 position})
      : super(
          position: position,
          size: Vector2.all(40), // Ukuran menara 40x40
          anchor: Anchor.center,
        );

  @override
  void update(double dt) {
    super.update(dt);
    _fireCooldown -= dt;

    if (_fireCooldown <= 0) {
      Enemy? target = _findTarget();
      if (target != null) {
        _shoot(target);
        _fireCooldown = 1 / fireRate;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Gambar placeholder menara (kotak biru)
    canvas.drawRect(size.toRect(), Paint()..color = towerColor);
    // Gambar jangkauan menara untuk debug
    final paint = Paint()
      ..color = const Color(0x88FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(Offset.zero, range, paint);
  }

  // Cari musuh terdekat dalam jangkauan
  Enemy? _findTarget() {
    Enemy? closestEnemy;
    double minDistance = double.infinity;

    for (var enemy in gameRef.children.whereType<Enemy>()) {
      double distance = position.distanceTo(enemy.position);
      if (distance <= range && distance < minDistance) {
        minDistance = distance;
        closestEnemy = enemy;
      }
    }
    return closestEnemy;
  }

  // Tembak musuh yang menjadi target
  void _shoot(Enemy target) {
    // Putar suara tembakan dengan penanganan error
    try {
      FlameAudio.play('shot.wav');
    } catch (e) {
      print("Error playing shot sound: $e");
    }

    final bullet = Bullet(
      position: position,
      target: target,
    );
    gameRef.add(bullet);
  }
}
