# Money Expense Tracker

Aplikasi pelacak pengeluaran pribadi yang dibangun dengan Flutter. Aplikasi ini memungkinkan pengguna untuk mencatat, melihat, dan menganalisis pengeluaran harian mereka dengan berbagai kategori.

## 📥 Download

[![Download APK](https://img.shields.io/badge/Download-APK-teal?logo=android&logoColor=white)](money_expense.apk)


## Fitur Utama

- ✅ Catat pengeluaran harian dengan kategori
- ✅ Lihat total pengeluaran hari ini dan bulan ini
- ✅ Tampilan pengeluaran berdasarkan kategori
- ✅ Detail pengeluaran hari ini dan kemarin
- ✅ Penyimpanan lokal menggunakan Hive database
- ✅ Antarmuka pengguna yang responsif dan menarik

## Teknologi yang Digunakan

- Flutter
- Hive (local database)
- Provider (state management)
- INTL (Rupiah converter)
- UUID (untuk ID unik)

## Prasyarat

- Flutter SDK = 3.27.2

## Instalasi & debug

1. Clone repository ini:
   ```bash
   git clone
   cd money_expense
   ```

2. Install dependensi:
   ```bash
   flutter pub get
   ```

3. Generate Hive adapters:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
   
4. Untuk menjalankan aplikasi dalam mode development:
   ```bash
   flutter run
   ```

## Struktur Folder

```
lib/
├── main.dart
├── models/
│   ├── expense.dart
│   └── expense.g.dart
├── providers/
│   └── expense_provider.dart
├── services/
│   └── expense_service.dart
└── ui/
    ├── pages/
    │   ├── home_page.dart
    │   └── add_expense_page.dart
    └── widgets/
        ├── expense_card.dart
        └── category_expense_card.dart
```
### Membangun Model Hive

Setiap kali Anda memodifikasi model Hive, Anda perlu menjalankan perintah berikut untuk mengenerate adapter:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Untuk menjalankan build runner dalam mode watch (otomatis rebuild saat ada perubahan):
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Membangun APK (Android)

#### APK Universal (untuk semua arsitektur)
```bash
flutter build apk --release
```

#### APK Split per ABI (untuk ukuran file yang lebih kecil)
```bash
flutter build apk --split-per-abi --release
```

Setelah build selesai, file APK akan tersedia di:
- `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk`
- `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`
- `build/app/outputs/flutter-apk/app-x86_64-release.apk`
