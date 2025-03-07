import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pokemon.dart';

class PokemonView extends StatefulWidget {
  @override
  _PokemonViewState createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  final TextEditingController _controller = TextEditingController();
  Pokemon? _pokemon;
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _fetchPokemon() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.get(Uri.parse(
          'https://pokeapi.co/api/v2/pokemon/${_controller.text.toLowerCase()}'));

      if (response.statusCode == 200) {
        setState(() {
          _pokemon = Pokemon.fromJson(json.decode(response.body));
        });
      } else {
        setState(() {
          _errorMessage = 'Pokémon no encontrado';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error de conexión';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Pokémon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nombre del Pokémon',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _fetchPokemon,
                ),
              ),
            ),
            if (_isLoading) const CircularProgressIndicator(),
            if (_errorMessage.isNotEmpty)
              Text(_errorMessage, style: TextStyle(color: Colors.red)),
            if (_pokemon != null)
              Card(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: _pokemon!.imageUrl,
                      height: 150,
                      placeholder: (context, url) => 
                         const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => 
                         const Icon(Icons.error),
                    ),
                    Text(_pokemon!.name, 
                        style: Theme.of(context).textTheme.headlineSmall),
                    Text('Experiencia base: ${_pokemon!.baseExperience}'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      children: _pokemon!.abilities
                          .map((ability) => Chip(label: Text(ability)))
                          .toList(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}