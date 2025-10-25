import 'dart:math';
import 'package:flame/components.dart';
import 'tower_defense_game.dart';
import 'enemy.dart';
import '../utils/constants.dart';

/// Mengelola gelombang (wave) musuh yang muncul.
class WaveManager extends Component {
  final TowerDefenseGame game;
  final Random _random = Random();

  int waveNumber = 1;
  int enemiesToSpawn = 10;
  int enemiesSpawned = 0;

  // Timer untuk memunculkan musuh
  final Timer _spawnTimer = Timer(2, repeat: true);

  WaveManager({required this.game});

  @override
  void onMount() {
    super.onMount();
    _spawnTimer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _spawnTimer.update(dt);

    if (_spawnTimer.finished && enemiesSpawned < enemiesToSpawn) {
      _spawnEnemy();
      enemiesSpawned++;
    }

    // Cek jika wave selesai dan mulai wave baru
    if (enemiesSpawned >= enemiesToSpawn && game.children.whereType<Enemy>().isEmpty) {
      _startNextWave();
    }
  }

  void _spawnEnemy() {
    // Atur HP dan kecepatan berdasarkan wave
    double enemyHp = 100.0 + (waveNumber - 1) * 20;
    double enemySpeed = 50.0 + (waveNumber - 1) * 5;

    final newEnemy = Enemy(
      position: Vector2(0, gameHeight / 2),
      hp: enemyHp,
      speed: enemySpeed,
    );
    game.add(newEnemy);
  }

  void _startNextWave() {
    waveNumber++;
    enemiesSpawned = 0;
    enemiesToSpawn = 10 + (waveNumber - 1) * 2; // Tambah jumlah musuh
    _spawnTimer.reset();
    _spawnTimer.start();

    // Anda bisa menambahkan notifikasi wave baru di sini
    print("Wave $waveNumber started!");
  }
}
