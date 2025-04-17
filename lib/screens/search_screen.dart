import 'package:flutter/material.dart';
import 'package:aplikasi_doa/models/doa_model.dart';
import 'package:aplikasi_doa/services/api_service.dart';
import 'package:aplikasi_doa/screens/detail_screen.dart';
import 'package:aplikasi_doa/widgets/bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Doa>> _futureDoa;
  List<Doa> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _futureDoa = ApiService.getAllDoa();
  }

  void _searchDoa(String query) async {
    final allDoa = await _futureDoa;
    setState(() {
      _searchResults =
          allDoa
              .where(
                (doa) =>
                    doa.judul.toLowerCase().contains(query.toLowerCase()) ||
                    doa.terjemah.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cari Doa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade700, // Green background
        iconTheme: const IconThemeData(color: Colors.white), // White icons
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari doa...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor:
                      Colors.grey[200], // Light yellow background color[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
                onChanged: _searchDoa,
              ),
            ),
            Expanded(
              child:
                  _searchController.text.isEmpty
                      ? const Center(
                        child: Text(
                          'Masukkan kata kunci pencarian',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final doa = _searchResults[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                doa.judul,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DetailScreen(doa: doa),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }
}
