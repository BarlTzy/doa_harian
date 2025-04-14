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
                    doa.title.toLowerCase().contains(query.toLowerCase()) ||
                    doa.translation.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cari Doa'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari doa...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _searchDoa,
            ),
          ),
          Expanded(
            child:
                _searchController.text.isEmpty
                    ? const Center(child: Text('Masukkan kata kunci pencarian'))
                    : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final doa = _searchResults[index];
                        return ListTile(
                          title: Text(doa.title),
                          subtitle: Text(doa.translation),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(doa: doa),
                              ),
                            );
                          },
                        );
                      },
                    ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }
}
