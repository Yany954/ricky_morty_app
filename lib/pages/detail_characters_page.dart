import 'package:flutter/material.dart';

class CharacterDetailPage extends StatelessWidget {
  final Map<String, dynamic> character;

  CharacterDetailPage({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(character['image']),
            SizedBox(height: 16),
            Text('Nombre: ${character['name']}'),
            Text('Estado: ${character['status']}'),
            Text('Especie: ${character['species']}'),
            Text('Género: ${character['gender']}'),
            Text('Origen: ${character['origin']['name']}'),
            Text('Ubicación actual: ${character['location']['name']}'),
          ],
        ),
      ),
    );
  }
}

