import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();
  final baseUrl = "https://rickandmortyapi.com/api";

  Future<Map<String, dynamic>> fetchCharacters() async {
    final response = await dio.get("$baseUrl/character");
    if (response.statusCode == 200) {

      print("fetchingCharacters-> ${response.data}");
      return response.data;
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<Map<String, dynamic>> fetchLocations() async {
    final response = await dio.get("$baseUrl/location");
    if (response.statusCode == 200) {

      print("fetchingLocations-> ${response.data}");
      return response.data;
    } else {
      throw Exception('Failed to load locations');
    }
  }

  Future<Map<String, dynamic>> fetchEpisodes() async {
    final response = await dio.get("$baseUrl/episode");
    if (response.statusCode == 200) {
      print("fetchingEpisodes-> ${response.data}");
      return response.data;
    } else {
      throw Exception('Failed to load episodes');
    }
  }
}
