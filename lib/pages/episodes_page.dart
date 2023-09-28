import 'package:flutter/material.dart';
import 'package:ricky_morty_app/services/ApiService.dart';

import 'episode_page.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({super.key});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  final ApiService apiService = ApiService();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Episodios de Rick and Morty'),
        ),
        body: FutureBuilder(
          future: apiService.fetchEpisodes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final episodes = snapshot.data?['results'];
              return ListView.builder(
                itemCount: episodes.length,
                itemBuilder: (context, index) {
                  final episode = episodes[index];
                  return ListTile(
                    title: Text(episode['name']),
                    subtitle: Text(episode['episode']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailEpisodePage(episode: episode),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      );
  }
}
