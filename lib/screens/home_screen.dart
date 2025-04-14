import 'package:flutter/material.dart';
import 'package:aplikasi_doa/models/doa_model.dart';
import 'package:aplikasi_doa/services/api_service.dart';
import 'package:aplikasi_doa/screens/detail_screen.dart';
import 'package:aplikasi_doa/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Doa>> _futureDoa;

  @override
  void initState() {
    super.initState();
    _futureDoa = ApiService.getAllDoa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kumpulan Doa'), centerTitle: true),
      body: FutureBuilder<List<Doa>>(
        future: _futureDoa,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Gagal memuat doa'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureDoa = ApiService.getAllDoa();
                      });
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final doaList = snapshot.data!;

          return ListView.builder(
            itemCount: doaList.length,
            itemBuilder: (context, index) {
              final doa = doaList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(doa.judul),
                  subtitle: Text(doa.terjemah),
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
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}
