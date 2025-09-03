import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Fungsi ini digunakan untuk menghindari error/exception
/// dari `mouse_tracker.dart` yang sering muncul saat debug
/// di physical device menggunakan **scrcpy** (screen mirroring).
///
/// Error tersebut biasanya berupa PointerAddedEvent assertion
/// akibat event mouse injection dari scrcpy.
/// Dengan override ini, error tersebut di-suppress agar tidak
/// mengganggu proses debug.
void avoidErrorMouseUsed() {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exceptionAsString().contains("mouse_tracker.dart")) {
      // ignore the error
      debugPrint("Suppressed PointerAddedEvent assertion.");
    } else {
      FlutterError.presentError(details);
    }
  };
}

/// Mengambil informasi `MediaQueryData` dari context.
/// MediaQuery berisi data tentang ukuran layar, padding, dsb.
MediaQueryData getMediaQuery(BuildContext context) => MediaQuery.of(context);

/// Mendapatkan lebar layar device dalam satuan logical pixel.
double getDeviceWidth(BuildContext context) =>
    getMediaQuery(context).size.width;

/// Mendapatkan tinggi layar device dalam satuan logical pixel.
double getDeviceHeight(BuildContext context) =>
    getMediaQuery(context).size.height;

/// Mengubah angka `double` menjadi format mata uang Rupiah (Rp).
///
/// Contoh:
/// ```dart
/// formatRupiah(15000); // Output: Rp 15.000
/// formatRupiah(1234567); // Output: Rp 1.234.567
/// ```
String formatRupiah(double value) {
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0, // kalau mau ada koma, ubah jadi 2
  );
  return formatCurrency.format(value);
}

String formatToRupiahTextField(String value) {
  if (value.isEmpty) return '';
  final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) return '';
  final number = double.parse(digits);
  return formatRupiah(number);
}

String formatDate(DateTime d) {
  const months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  const weekdays = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];
  final wd = weekdays[d.weekday - 1];
  final m = months[d.month - 1];
  return '$wd, ${d.day} $m ${d.year}';
}
