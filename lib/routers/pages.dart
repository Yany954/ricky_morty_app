import 'package:flutter/material.dart';
import 'package:ricky_morty_app/pages/characters_page.dart';
import 'package:ricky_morty_app/pages/detail_characters_page.dart';
import 'package:ricky_morty_app/pages/episode_page.dart';
import 'package:ricky_morty_app/pages/episodes_page.dart';
import 'package:ricky_morty_app/pages/home_page.dart';
import 'package:ricky_morty_app/pages/login_page.dart';
import 'package:ricky_morty_app/routers/routes.dart';

Map<String, Widget Function(BuildContext)>appRoutes(){
  return{
    //se llaman las rutas definidas en routes
    Routes.HOME:(_)=> Homepage(),
    Routes.LOGIN:(_)=> LoginPage(),
    Routes.CHARACTERS:(_)=>CharactersPage(),
    Routes.EPISODES:(_)=>EpisodesPage()


  };
}