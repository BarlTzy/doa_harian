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
      appBar: AppBar(
        title: const Text(
          'Doa Favorit',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade700, // Green background color
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // White back button
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Colors.green,
        //       Colors.white, // Fading to white
        //     ],
        //     stops: [0.05, 0.05], // Only first 5% is green
        //   ),
        // ),
        child: FutureBuilder<List<Doa>>(
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
              return const Center(
                child: Text(
                  'Belum ada doa favorit',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.only(
                top: 8,
              ), // Space below green header
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final doa = favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      doa.judul,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),

                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
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
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }
}
