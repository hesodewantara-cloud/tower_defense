import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

/// Komponen visual untuk efek ledakan.
class ExplosionEffect extends CircleComponent {
  ExplosionEffect({required Vector2 position})
      : super(
          position: position,
          anchor: Anchor.center,
          paint: Paint()..color = const Color(0xFFFFC107), // Warna oranye
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Efek untuk membesarkan ukuran dan memudarkan komponen, lalu menghapusnya.
    add(
      ScaleEffect.to(
        Vector2.all(5),
        EffectController(duration: 0.3),
      ),
    );
    add(
      OpacityEffect.fadeOut(
        EffectController(duration: 0.3),
        onComplete: () => removeFromParent(),
      ),
    );
  }
}
