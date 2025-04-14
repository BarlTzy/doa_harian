import 'package:flutter/material.dart';
import 'package:aplikasi_doa/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kumpulan Doa',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Poppins'),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
