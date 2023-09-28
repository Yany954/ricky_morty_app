import 'package:flutter/material.dart';

import '../routers/routes.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0x6f504e4e),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment(0.0, 1.0),
                  colors: const <Color>[
                    Color(0xfffafafa),
                    Color(0x6f504e4e),
                  ],
                  tileMode: TileMode.repeated),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  /*Image.asset(
                    'assets/logo.png',
                    height: 200,
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Ricky y Morty",
                            style: TextStyle(
                              color: Color(0xFF7DBB47),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2, // Número de columnas
                      children: <Widget>[
                        Card(
                          elevation: 5.0,
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.pushNamed(context, Routes.CHARACTERS);
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /*Image.asset(
                                    'assets/agregar-contacto.png',
                                    height: 90,
                                  ),*/
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Personajes",
                                    style: TextStyle(
                                      color: Color(0xFFBB478E),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Card(
                          elevation: 5.0,
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.EPISODES);
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /*Image.asset(
                                    'assets/equipo.png',
                                    height: 90,
                                  ),*/
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Episodios",
                                    style: TextStyle(
                                      color: Color(0xFFBB478E),
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
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
      );
  }
}
