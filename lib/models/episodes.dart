import 'package:ricky_morty_app/models/episode.dart';

class EpisodeList {
  final int count;
  final int pages;
  final String? next;
  final String? prev;
  final List<Episode> episodes;

  EpisodeList({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
    required this.episodes,
  });

  factory EpisodeList.fromJson(Map<String, dynamic> json) {
    return EpisodeList(
      count: json['info']['count'],
      pages: json['info']['pages'],
      next: json['info']['next'],
      prev: json['info']['prev'],
      episodes: (json['results'] as List).map((episodeJson) {
        return Episode.fromJson(episodeJson);
      }).toList(),
    );
  }
}

