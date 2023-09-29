import 'package:flutter/material.dart';
import '../routers/routes.dart';
import '../utils/widgets/CustomBottomNavBar.dart';

class CharacterDetailPage extends StatefulWidget {
  final Map<String, dynamic> character;

  CharacterDetailPage({required this.character});

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  int _currentIndex = 0;

  Widget _buildRichText(String label, String value, double fontSize, Color valueColor, Color labelColor) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: TextStyle(
              color: labelColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: valueColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showCharacterDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      _buildRichText('Estado:', widget.character['status'], 20.0, Colors.black87, Color(0xFF06B1C7)),
                      _buildRichText('Especie:', widget.character['species'], 20.0, Colors.black87, Color(0xFF06B1C7)),
                      _buildRichText('Género:', widget.character['gender'], 20.0, Colors.black87, Color(0xFF06B1C7)),
                      _buildRichText('Origen:', widget.character['origin']['name'], 20.0, Colors.black87, Color(0xFF06B1C7)),
                      _buildRichText('Ubicación actual:', widget.character['location']['name'], 20.0, Colors.black87, Color(0xFF06B1C7)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCharacterImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.network(
        widget.character['image'],
        width: 300.0,
        height: 300.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildMoreDetailsButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showCharacterDetails(context);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        backgroundColor: Color(0xFF06B1C7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.touch_app),
          SizedBox(width: 8.0),
          Text(
            'Más detalles',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/login_background.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xD0171717).withOpacity(0.2),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.0,),
                    Text(
                      widget.character['name'].toString().toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    _buildCharacterImage(),
                    SizedBox(height: 20),
                    _buildMoreDetailsButton(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
}
