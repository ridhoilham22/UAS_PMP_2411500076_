import 'dart:async';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.blueAccent, // Menggunakan warna biru aksen agar serasi
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Mengubah ikon menjadi bertema sepatu
            Icon(Icons.ice_skating, size: 90, color: Colors.white),

            SizedBox(height: 20),

            // Mengubah teks judul menjadi Aplikasi Data Sepatu
            Text(
              "Aplikasi Data Sepatu",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "CRUD Hive Flutter",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),

            SizedBox(height: 40),

            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
