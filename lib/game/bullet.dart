import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../utils/constants.dart';
import 'enemy.dart';

/// Class yang merepresentasikan peluru yang ditembakkan oleh menara.
class Bullet extends PositionComponent with CollisionCallbacks {
  final Enemy target;
  final double speed = 300.0;
  final double damage = 25;
  late Vector2 velocity;

  Bullet({
    required Vector2 position,
    required this.target,
  }) : super(
          position: position,
          size: Vector2.all(10), // Ukuran peluru 10x10
          anchor: Anchor.center,
        );

  @override
  void onLoad() {
    super.onLoad();
    add(CircleHitbox()); // Tambahkan hitbox untuk deteksi tumbukan
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (target.isRemoved) {
      removeFromParent(); // Hapus peluru jika target sudah hilang
      return;
    }

    // Arahkan peluru ke target
    final direction = (target.position - position).normalized();
    velocity = direction * speed;
    position += velocity * dt;

    // Putar peluru agar menghadap target (opsional)
    angle = velocity.screenAngle();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Gambar placeholder peluru (kotak kuning)
    canvas.drawRect(size.toRect(), Paint()..color = bulletColor);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      other.takeDamage(damage);
      removeFromParent(); // Hapus peluru setelah mengenai musuh
    }
  }
}
