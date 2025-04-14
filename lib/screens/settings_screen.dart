import 'package:flutter/material.dart';
import 'package:aplikasi_doa/widgets/bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Tentang Aplikasi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Kumpulan_Doa v1.0'),
          const Divider(height: 32),
          const Text(
            'Sumber Data',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('API: doa-doa-api-ahmadramadhan.fly.dev'),
          const Divider(height: 32),
          const Text(
            'Tema Aplikasi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildThemeOption(Colors.green, context),
              _buildThemeOption(Colors.blue, context),
              _buildThemeOption(Colors.purple, context),
            ],
          ),
          const Divider(height: 32),
          const Text(
            'Ukuran Font',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('A', style: TextStyle(fontSize: 16)),
              Text('A', style: TextStyle(fontSize: 20)),
              Text('A', style: TextStyle(fontSize: 24)),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }

  Widget _buildThemeOption(Color color, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement theme change
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
