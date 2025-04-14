import 'package:flutter/material.dart';
import 'package:aplikasi_doa/models/doa_model.dart';
import 'package:aplikasi_doa/services/favorite_service.dart';
import 'package:aplikasi_doa/screens/detail_screen.dart';
import 'package:aplikasi_doa/widgets/bottom_nav_bar.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doa Favorit'), centerTitle: true),
      body: FutureBuilder<List<Doa>>(
        future: FavoriteService.getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final favorites = snapshot.data!;

          if (favorites.isEmpty) {
            return const Center(child: Text('Belum ada doa favorit'));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final doa = favorites[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(doa.judul),
                  subtitle: Text(doa.terjemah),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await FavoriteService.removeFavorite(doa.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Doa dihapus dari favorit'),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(doa: doa),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }
}
