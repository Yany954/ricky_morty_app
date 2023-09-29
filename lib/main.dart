import 'package:flutter/material.dart';
import 'package:ricky_morty_app/routers/pages.dart';
import 'package:ricky_morty_app/routers/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ricky & Morty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: Routes.SPLASH,
      routes: appRoutes(),
    );
  }
}
