import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/character.dart';
import '../models/episodes.dart';

class ApiService {
  final baseUrl = "https://rickandmortyapi.com/api";

  Future<Map<String, dynamic>> fetchCharacters() async {
    final response = await http.get(Uri.parse("$baseUrl/character"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("fetchingCharacters-> $data");
      return data;
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<Map<String, dynamic>> searchCharacters(String name) async {
    final response = await http.get(Uri.parse("$baseUrl/character?name=$name"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("searchCharacters-> $data");
      return data;
    } else {
      throw Exception('Failed to search characters by name');
    }
  }

  Future<Map<String, dynamic>> fetchLocations() async {
    final response = await http.get(Uri.parse("$baseUrl/location"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("fetchingLocations-> $data");
      return data;
    } else {
      throw Exception('Failed to load locations');
    }
  }

  Future<EpisodeList> fetchEpisodes() async {
    final response = await http.get(Uri.parse("$baseUrl/episode"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final episodeList = EpisodeList.fromJson(data);
      print("fetchingEpisodes-> $data");
      return episodeList;
    } else {
      throw Exception('Failed to load episodes');
    }
  }

  Future<EpisodeList> fetchNextEpisodesPage(int currentPage) async {
    final response = await http.get(Uri.parse("$baseUrl/episode?page=${currentPage + 1}"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final episodeList = EpisodeList.fromJson(data);
      print("fetchingEpisodes-> $data");
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
        final response = await http.get(Uri.parse("$url"));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final character = Character.fromJson(data);
          characters.add(character);
        }
      } catch (e) {
        print('Error loading character from URL: $url');
      }
    }
    return characters;
  }
}
