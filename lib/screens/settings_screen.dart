import 'package:flutter/material.dart';
import 'package:aplikasi_doa/widgets/bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false, // Menghilangkan ikon back
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Ganti Tema
          _buildSettingItem(
            title: 'Ganti Tema',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildThemeOption(Colors.green, context),
                _buildThemeOption(Colors.blue, context),
                _buildThemeOption(Colors.purple, context),
              ],
            ),
          ),
          const Divider(height: 32),

          // Ukuran Font
          _buildSettingItem(
            title: 'Atur Ukuran Font',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('A', style: TextStyle(fontSize: 16)),
                Text('A', style: TextStyle(fontSize: 20)),
                Text('A', style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
          const Divider(height: 32),

          // Versi Aplikasi
          _buildSettingItem(
            title: 'Versi Aplikasi',
            child: const Text('1.0.0', style: TextStyle(color: Colors.grey)),
          ),
          const Divider(height: 32),

          // Bestar
          _buildSettingItem(
            title: 'Beri Rating',
            child: const Icon(Icons.star, color: Colors.amber),
          ),
          const Divider(height: 32),

          // Ketentuan & Layanan
          _buildSettingItem(
            title: 'Ketentuan & Layanan',
            child: const Icon(Icons.chevron_right, color: Colors.grey),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }

  Widget _buildSettingItem({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        child,
      ],
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
