import 'package:flutter/material.dart';
import 'package:ricky_morty_app/services/ApiService.dart';

import '../routers/routes.dart';
import '../utils/widgets/CustomBottomNavBar.dart';
import 'detail_characters_page.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ApiService apiService = ApiService();
  List<dynamic> characters = [];
  TextEditingController searchController = TextEditingController();
  bool searching = false;
  int _currentIndex = 0;

  void searchCharacters(String query) async {
    if (query.isEmpty) {
      setState(() {
        characters.clear();
        searching = false;
      });
      return;
    }

    try {
      final result = await apiService.searchCharacters(query);
      setState(() {
        characters = result['results'];
        searching = true;
      });
    } catch (error) {
      print('Error: $error');
    }
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
              color: Color(0xD0171717)
                  .withOpacity(0.7), // Fondo negro medio transparente
            ),
          ),
          // Resto de tu contenido
          Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Text(
                'PERSONAJES', // Título "Personajes"
                style: TextStyle(
                  color: Color(0xFF06B1C7),
                  fontSize: 25, // Tamaño de fuente del título
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (query) => searchCharacters(query),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  // Estilo del texto
                  decoration: InputDecoration(
                    labelText: 'Buscar personaje por nombre',
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Roboto'),
                    // Estilo del texto de etiqueta
                    hintText: 'Introduzca el nombre del personaje',
                    hintStyle: TextStyle(color: Colors.white),
                    // Estilo del texto de sugerencia
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white, // Color del icono
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      // Color del borde del campo de entrada
                      borderRadius: BorderRadius.circular(
                          10.0), // Radio de borde para redondear
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      // Color del borde cuando el campo está enfocado
                      borderRadius: BorderRadius.circular(
                          10.0), // Radio de borde para redondear
                    ),
                  ),
                ),
              ),
              Expanded(
                child: searching
                    ? _buildCharacterList(characters)
                    : FutureBuilder(
                        future: apiService.fetchCharacters(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return _buildCharacterList(
                                snapshot.data?['results']);
                          }
                        },
                      ),
              ),
            ],
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
            Navigator.pushNamed(
                context, Routes.CHARACTERS); // Navega a la página "Home"
          } else if (index == 1) {
            Navigator.pushNamed(
                context, Routes.HOME); // Navega a la página "Characters"
          } else if (index == 2) {
            Navigator.pushNamed(
                context, Routes.EPISODES); // Navega a la página "Episodes"
          }
        },
      ),
    );
  }

  Widget _buildCharacterList(List<dynamic>? characters) {
    if (characters == null || characters.isEmpty) {
      return Center(child: Text('No se encontraron personajes.'));
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Cambia esto según el número de tarjetas por fila
      ),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        final imageUrl = character['image'];
        final name = character['name'];
        return Card(
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CharacterDetailPage(character: character),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    imageUrl, // Utiliza la URL de la imagen del personaje
                    width: 120, // Ajusta el tamaño según tus necesidades
                    height: 120, // Ajusta la altura según tus necesidades
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  name, // Nombre del personaje
                  style: TextStyle(
                    fontSize: 17, // Tamaño de fuente
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
