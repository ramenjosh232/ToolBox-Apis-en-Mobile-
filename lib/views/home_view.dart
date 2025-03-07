import 'package:flutter/material.dart';

import 'package:multitool_app/views/pokemon_view.dart';
import '../views/gender_view.dart';
import '../views/age_view.dart';
import '../views/about_view.dart';
import '../views/news_view.dart';
import '../views/university_view.dart';
import '../views/weather_view.dart';


class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MultiTool App')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Image.asset('assets/images/toolbox.png')),
            ListTile(
              title: Text('Género'),
              onTap: () => Navigator.push(context, 
                MaterialPageRoute(builder: (_) => GenderView())),
            ),
            ListTile(
              title: Text('Acerca de Mí'),
              onTap: () => Navigator.push(context, 
                MaterialPageRoute(builder: (_) => AboutView())),
            ),
            ListTile(
              title: Text('Edad'),
              onTap: () => Navigator.push(context, 
                MaterialPageRoute(builder: (_) => AgeView())),
            ),  
            ListTile(
              title: Text('Universidades'),
              onTap: () => Navigator.push(context, 
                MaterialPageRoute(builder: (_) => UniversityView())),
            ),
            ListTile(
              title: Text('Noticias'),
              onTap: () => Navigator.push(context, 
                MaterialPageRoute(builder: (_) => NewsView())),
            ),
             ListTile( 
      title: Text('Clima'),
      onTap: () => Navigator.push(context, 
        MaterialPageRoute(builder: (_) => WeatherView())),
    ),
            
            ListTile(
              title: Text('Pokemon'),
              onTap: () => Navigator.push(context, 
                MaterialPageRoute(builder: (_) => PokemonView())),
            ),

          ],
        ),
      ),
      body: Center(child: Image.asset('assets/images/toolbox.png')),
    );
  }
}