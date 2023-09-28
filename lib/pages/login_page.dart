import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              color: Color(0xD0171717).withOpacity(0.7), // Fondo negro medio transparente
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: Image.asset(
                      'assets/images/logo_login.png', // Path to your asset image
                      width: 400, // Adjust the width as needed
                      height: 180, // Adjust the height as needed
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: usernameController,
                            style: TextStyle(color: Colors.white, fontSize: 18), // Increase font size
                            decoration: InputDecoration(
                              labelText: 'Nombre de Usuario',
                              labelStyle: TextStyle(color: Colors.white, fontSize: 18), // Increase font size
                              hintText: 'Introduzca su nombre de usuario',
                              hintStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: passwordController,
                            style: TextStyle(color: Colors.white, fontSize: 18), // Increase font size
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(color: Colors.white, fontSize: 18), // Increase font size
                              hintText: 'Introduzca su contraseña',
                              hintStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                            ),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          color: Colors.transparent,
                          width: double.infinity, // Set the width to the maximum available width
                          padding: EdgeInsets.all(16.0), // Padding for the button
                          child: ElevatedButton(
                            onPressed: () {
                              if (usernameController.text == 'usuario' &&
                                  passwordController.text == 'contrasena') {
                                Navigator.pushReplacementNamed(context, '/home');
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error de inicio de sesión'),
                                      content: Text('Nombre de usuario o contraseña incorrectos.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Aceptar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 2.0,
                              backgroundColor: Color(0xFF06B1C7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Container( // Wrap the button child in a Container
                              width: double.infinity,
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              // Set the width of the button to match the parent Container
                              child: Text(
                                'Iniciar Sesión',
                                softWrap: true,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
