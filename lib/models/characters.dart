import 'package:ricky_morty_app/models/character.dart';

class CharacterList {
  final int count;
  final int pages;
  final String? next;
  final String? prev;
  final List<Character> characters;

  CharacterList({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
    required this.characters,
  });

  factory CharacterList.fromJson(Map<String, dynamic> json) {
    return CharacterList(
      count: json['info']['count'],
      pages: json['info']['pages'],
      next: json['info']['next'],
      prev: json['info']['prev'],
      characters: (json['results'] as List).map((characterJson) {
        return Character
            .fromJson(characterJson);
      }).toList(),
    );
  }
}

