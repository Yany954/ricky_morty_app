import 'package:flutter/material.dart';
import 'package:ricky_morty_app/models/episode.dart';
import 'package:ricky_morty_app/services/ApiService.dart';
import '../models/episodes.dart';
import '../routers/routes.dart';
import '../utils/widgets/CustomBottomNavBar.dart';
import 'episode_page.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({Key? key}) : super(key: key);

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  final ApiService apiService = ApiService();
  int _currentIndex = 2;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;
  EpisodeList? episodeListData;

  @override
  void initState() {
    super.initState();
    _loadAllEpisodes();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadAllEpisodes();
    }
  }

  Future<void> _loadAllEpisodes() async {
    final int maxPages = 2;

    for (int page = 0; page <= maxPages; page++) {
      try {
        final nextEpisodes = await apiService.fetchNextEpisodesPage(page);
        final List<Episode> updatedEpisodes = [
          ...(episodeListData?.episodes ?? []),
          ...nextEpisodes.episodes.cast<Episode>(),
        ];
        setState(() {
          episodeListData = EpisodeList(episodes: updatedEpisodes);
        });
      } catch (error) {
        print('Error loading episodes on page $page: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildEpisodesList(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/login_background.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildEpisodesList() {
    if (episodeListData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final episodes = episodeListData!.episodes;
    final Map<String, List<Episode>> episodesBySeason = groupEpisodesBySeason(episodes);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: episodesBySeason.keys.map((seasonTitle) {
            final seasonEpisodes = episodesBySeason[seasonTitle]!;
            return _buildSeasonSection(seasonTitle, seasonEpisodes);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSeasonSection(String seasonTitle, List<Episode> seasonEpisodes) {
    return Column(
      children: [
        SizedBox(height: 20.0),
        Text(
          seasonTitle,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF05C2DC),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: seasonEpisodes.length,
            itemBuilder: (context, index) {
              final episode = seasonEpisodes[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: buildEpisodeCard(episode),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildEpisodeCard(Episode episode) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailEpisodePage(episode: episode),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Container(
          width: 220.0,
          child: ListTile(
            title: Text(
              episode.name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF06B1C7),
              ),
              maxLines: 3,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              episode.episode,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Map<String, List<Episode>> groupEpisodesBySeason(List<Episode> episodes) {
    final Map<String, List<Episode>> episodesBySeason = {};

    for (final episode in episodes) {
      final season = getSeasonFromEpisode(episode.episode);
      episodesBySeason.putIfAbsent(season, () => []);
      episodesBySeason[season]!.add(episode);
    }

    return episodesBySeason;
  }

  String getSeasonFromEpisode(String episode) {
    final season = episode.substring(1, 3);
    return 'Temporada $season';
  }
}
