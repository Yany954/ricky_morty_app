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
      backgroundColor: Colors.transparent, // Fondo transparente
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white, // Fondo transparente
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de pantalla
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
              color: Color(0xD0171717).withOpacity(0.2), // Fondo negro medio transparente
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0), // Redondear los bordes de la imagen
                      child: Image.network(
                        widget.character['image'],
                        width: 300.0, // Ancho de la imagen
                        height: 300.0, // Alto de la imagen
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(

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
                            'Ver Detalles',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
          // Maneja la navegación según el índice seleccionado
          if (index == 0) {
            Navigator.pushNamed(context, Routes.CHARACTERS); // Navega a la página "Home"
          } else if (index == 1) {
            Navigator.pushNamed(context, Routes.HOME); // Navega a la página "Characters"
          } else if (index == 2) {
            Navigator.pushNamed(context, Routes.EPISODES); // Navega a la página "Episodes"
          }
        },
      ),
    );
  }
}
