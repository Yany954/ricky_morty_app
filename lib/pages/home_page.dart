import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import '../routers/routes.dart';
import '../utils/widgets/CustomBottomNavBar.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xD0171717), // Fondo negro medio transparente
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Sin sombra
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), // Radio de borde para redondear
                color:  Color(0xFF05C2DC),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Aquí puedes agregar la lógica para cerrar sesión y redirigir al LoginPage
                  Navigator.pushReplacementNamed(context, Routes.LOGIN);
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
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
                color: Color(0xD0171717).withOpacity(0.7), // Fondo negro medio transparente
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/menu_banner.png',
                      width: MediaQuery.of(context).size.width, // Ajusta el tamaño según tus necesidades
                      height: 300.0, // Ajusta la altura según tus necesidades
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                    // Resto de tu contenido
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "¡Wubba lubba dub dub!",
                          style: TextStyle(
                            color: Color(0xFF05C2DC),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "¡Bienvenidos a la diversión, amigos!",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),bottomNavigationBar: CustomBottomNavBar( // Usa el widget personalizado
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
