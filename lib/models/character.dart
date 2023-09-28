
class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String originName;
  final String originUrl;
  final String locationName;
  final String locationUrl;
  final String imageUrl;
  final List<String> episodeUrls;
  final String url;
  final DateTime created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.originName,
    required this.originUrl,
    required this.locationName,
    required this.locationUrl,
    required this.imageUrl,
    required this.episodeUrls,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      originName: json['origin']['name'],
      originUrl: json['origin']['url'],
      locationName: json['location']['name'],
      locationUrl: json['location']['url'],
      imageUrl: json['image'],
      episodeUrls: (json['episode'] as List).cast<String>(),
      url: json['url'],
      created: DateTime.parse(json['created']),
    );
  }
}