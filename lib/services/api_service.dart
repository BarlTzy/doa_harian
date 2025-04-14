import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasi_doa/models/doa_model.dart';

class ApiService {
  static const String _baseUrl =
      'https://doa-doa-api-ahmadramadhan.fly.dev/api';

  static Future<List<Doa>> getAllDoa() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Doa.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load doa');
    }
  }

  static Future<Doa> getDoaById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      return Doa.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load doa details');
    }
  }
}
