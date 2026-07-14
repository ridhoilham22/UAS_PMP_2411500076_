import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'splashscreen.dart';
import 'home_page.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Hive.initFlutter();

  
  await Hive.openBox("sepatuBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Data Sepatu', 
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3:
            false, 
      ),
      home: const SplashScreen(),
    );
  }
}
