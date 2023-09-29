import 'package:flutter/material.dart';
import 'package:ricky_morty_app/models/episode.dart';
import 'package:ricky_morty_app/models/character.dart';
import 'package:ricky_morty_app/services/ApiService.dart';
import '../routers/routes.dart';
import '../utils/widgets/CustomBottomNavBar.dart';

class DetailEpisodePage extends StatefulWidget {
  final Episode episode;

  DetailEpisodePage({required this.episode});

  @override
  State<DetailEpisodePage> createState() => _DetailEpisodePageState();
}

class _DetailEpisodePageState extends State<DetailEpisodePage> {
  int _currentIndex = 2;
  final ApiService apiService = ApiService();

  List<Character> loadedCharacters = [];

  @override
  void initState() {
    super.initState();
    loadCharacters();
  }

  Future<void> loadCharacters() async {
    final characters =
        await apiService.charactersFromUrls(widget.episode.characters);
    setState(() {
      loadedCharacters = characters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.pushNamed(context, Routes.CHARACTERS);
          } else if (index == 1) {
            Navigator.pushNamed(context, Routes.HOME);
          } else if (index == 2) {
            Navigator.pushNamed(context, Routes.EPISODES);
          }
        },
      ),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        buildBackgroundImage(),
        buildBackgroundOverlay(),
        buildContent(),
      ],
    );
  }

  Widget buildBackgroundImage() {
    return Image.asset(
      'assets/images/login_background.jpg',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
    );
  }

  Widget buildBackgroundOverlay() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color(0xD0171717).withOpacity(0.7),
      ),
    );
  }

  Widget buildContent() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            buildBannerImage(),
            SizedBox(height: 20),
            buildEpisodeName(),
            SizedBox(height: 20),
            buildEpisodeInfo(),
            SizedBox(height: 20),
            buildCharacterList(),
          ],
        ),
      ),
    );
  }

  Widget buildBannerImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        'assets/images/episodes_banner.png',
        width: 300.0,
        height: 300.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildEpisodeName() {
    return Text(
      widget.episode.name.toUpperCase(),
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Color(0xFF05C2DC),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget buildEpisodeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRow("Episodio: ", widget.episode.episode),
        SizedBox(
          height: 16.0,
        ),
        buildInfoRow("Fecha de Lanzamiento: ", widget.episode.airDate),
        SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Personajes: ",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInfoRow(String label, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildCharacterList() {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: loadedCharacters.length,
        itemBuilder: (context, index) {
          final character = loadedCharacters[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildCharacterCard(character),
          );
        },
      ),
    );
  }

  Widget buildCharacterCard(Character character) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            character.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 100,
          child: Text(
            character.name,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
