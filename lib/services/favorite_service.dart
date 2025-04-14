import 'package:aplikasi_doa/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aplikasi_doa/models/doa_model.dart';

class FavoriteService {
  static const String _key = 'favorite_doas';

  static Future<void> addFavorite(Doa doa) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.add(doa);
    await prefs.setStringList(
      _key,
      favorites.map((d) => d.id.toString()).toList(),
    );
  }

  static Future<void> removeFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.removeWhere((d) => d.id == id);
    await prefs.setStringList(
      _key,
      favorites.map((d) => d.id.toString()).toList(),
    );
  }

  static Future<List<Doa>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    final allDoas = await ApiService.getAllDoa();
    return allDoas.where((doa) => ids.contains(doa.id.toString())).toList();
  }

  static Future<bool> isFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    return ids.contains(id.toString());
  }
}
