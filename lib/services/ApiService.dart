import 'package:dio/dio.dart';

import '../models/character.dart';
import '../models/episodes.dart';

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

  Future<Map<String, dynamic>> searchCharacters(String name) async {
    final response = await dio.get("$baseUrl/character?name=$name");
    if (response.statusCode == 200) {
      print("searchCharacters-> ${response.data}");
      return response.data;
    } else {
      throw Exception('Failed to search characters by name');
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

  Future<EpisodeList> fetchEpisodes() async {
    final response = await dio.get("$baseUrl/episode");
    if (response.statusCode == 200) {
      final episodeList = EpisodeList.fromJson(response.data);
      print("fetchingEpisodes-> ${response.data}");
      return episodeList;
    } else {
      throw Exception('Failed to load episodes');
    }
  }
  Future<EpisodeList> fetchNextEpisodesPage(int currentPage) async {
    final response = await dio.get("$baseUrl/episode?page=${currentPage + 1}");
    if (response.statusCode == 200) {
      final episodeList = EpisodeList.fromJson(response.data);
      print("fetchingEpisodes-> ${response.data}");
      currentPage++; // Actualiza la página actual
      return episodeList;
    } else {
      throw Exception('Failed to load next episodes page');
    }
  }
  // Function to load characters from character URLs
  Future<List<Character>> charactersFromUrls(List<String> characterUrls) async {
    List<Character> characters = [];
    for (String url in characterUrls) {
      try {
        final response = await dio.get("$url");
        if (response.statusCode == 200) {
          final character = Character.fromJson(response.data);
          characters.add(character);
        }
      } catch (e) {
        print('Error loading character from URL: $url');
      }
    }
    return characters;
  }

}
