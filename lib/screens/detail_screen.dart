import 'package:flutter/material.dart';
import 'package:aplikasi_doa/models/doa_model.dart';
import 'package:aplikasi_doa/services/favorite_service.dart';
import 'package:aplikasi_doa/widgets/bottom_nav_bar.dart';

class DetailScreen extends StatefulWidget {
  final Doa doa;

  const DetailScreen({super.key, required this.doa});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    final isFav = await FavoriteService.isFavorite(widget.doa.id);
    setState(() {
      _isFavorite = isFav;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await FavoriteService.removeFavorite(widget.doa.id);
    } else {
      await FavoriteService.addFavorite(widget.doa);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doa.judul),
        // DIHAPUS: Icon favorite dari appbar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.doa.arab,
              style: const TextStyle(fontSize: 24, fontFamily: 'Amiri'),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16),
            Text(
              widget.doa.latin,
              style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.doa.terjemah,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // TAMBAHKAN: Favorite button di sini
                ElevatedButton.icon(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : null,
                  ),
                  label: Text(_isFavorite ? 'Favorit' : 'Tambahkan ke Favorit'),
                  onPressed: _toggleFavorite,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text('Bagikan'),
                  onPressed: () {
                    // Implement share functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}
