# tower_defense 
Buatkan sebuah game Tower Defense 2D menggunakan Flutter dengan engine Flame.

🎮 DESKRIPSI GAME:
Game ini bertema pertahanan menara (tower defense) bergaya sci-fi sederhana. Pemain harus menahan gelombang musuh yang datang dengan menempatkan menara di sepanjang jalur. Musuh berjalan dari kiri ke kanan, dan jika berhasil melewati seluruh jalur, pemain kehilangan nyawa. Tujuannya adalah bertahan selama mungkin.

📦 TEKNOLOGI:
- Gunakan Flutter dan package Flame
- Gunakan Flame components: SpriteComponent, PositionComponent, TextComponent
- Gunakan Flame Audio untuk efek suara (tembakan, ledakan, dan background music)
- Gunakan sistem `GameWidget` sebagai root widget
- Gunakan file terpisah untuk setiap class (misalnya enemy.dart, tower.dart, bullet.dart, game.dart)

📁 STRUKTUR PROJECT:
lib/
 ├─ main.dart
 ├─ game/
 │   ├─ tower_defense_game.dart
 │   ├─ enemy.dart
 │   ├─ tower.dart
 │   ├─ bullet.dart
 │   └─ wave_manager.dart
 ├─ ui/
 │   ├─ main_menu.dart
 │   ├─ game_over_screen.dart
 │   └─ hud.dart
 └─ utils/
     └─ constants.dart

🎨 DETAIL FITUR:
1. **Main Menu**
   - Tombol “Play”, “Exit”
   - Latar belakang bergambar galaksi
   - Ketika menekan “Play”, masuk ke game utama

2. **Gameplay**
   - Ukuran layar 800x600 (auto-scale untuk HP)
   - Pemain bisa menempatkan menara di titik tertentu (koordinat sudah ditentukan)
   - Menara otomatis menembak musuh dalam jarak radius 150px
   - Musuh muncul setiap 2 detik dalam gelombang (wave)
   - Musuh berjalan sepanjang jalur menuju base
   - Jika musuh mencapai base → nyawa berkurang 1
   - Setiap musuh mati → pemain mendapat 10 koin
   - Pemain bisa membeli menara baru dengan koin
   - Jika nyawa = 0 → masuk ke layar Game Over

3. **Game Over Screen**
   - Tampilkan skor akhir dan tombol “Restart” atau “Main Menu”

4. **Visual dan Animasi**
   - Gunakan sprite sederhana (bisa placeholder warna)
   - Tambahkan efek ledakan kecil ketika musuh mati
   - Tambahkan suara tembakan dan efek suara background loop

5. **Logic Tambahan**
   - Gunakan update(dt) untuk pergerakan musuh dan peluru
   - Tambahkan deteksi collision antara bullet dan enemy
   - Buat sistem wave (gelombang) meningkat setiap 10 musuh
   - Difficulty naik setiap wave (musuh lebih cepat dan HP meningkat)

🧠 CATATAN TAMBAHAN:
- Pastikan semua kode dapat dijalankan langsung di Flutter (Android/Web)
- Sertakan penjelasan singkat di setiap class
- Buat kode seefisien mungkin dan mudah dipahami
- Jangan gunakan package tambahan selain `flame`, `flame_audio`, dan `flutter/material.dart`
- Sertakan contoh asset placeholder (misal warna atau bentuk sederhana)
