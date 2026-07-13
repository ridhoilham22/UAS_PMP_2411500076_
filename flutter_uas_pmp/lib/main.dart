import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'splashscreen.dart';
import 'home_page.dart'; // Pastikan file home_page.dart sudah diubah ke versi sepatu

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Hive untuk Flutter
  await Hive.initFlutter();

  // Membuka box baru khusus untuk data sepatu
  await Hive.openBox("sepatuBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Data Sepatu', // Judul aplikasi disesuaikan
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3:
            false, // Menjaga konsistensi tema jika Anda menggunakan primarySwatch
      ),
      home: const SplashScreen(),
    );
  }
}
