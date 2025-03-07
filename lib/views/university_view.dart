import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../models/university.dart';

class UniversityView extends StatefulWidget {
  @override
  _UniversityViewState createState() => _UniversityViewState();
}

class _UniversityViewState extends State<UniversityView> {
  List<University> _universities = [];
  final _controller = TextEditingController();

  Future<void> _fetchUniversities() async {
    final response = await http.get(Uri.parse(
        'http://universities.hipolabs.com/search?country=${_controller.text.replaceAll(' ', '+')}'));
    if (response.statusCode == 200) {
      setState(() {
        _universities = (json.decode(response.body) as List)
            .map((data) => University.fromJson(data))
            .toList();
      });
    }
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('No se pudo abrir $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Universidades')),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Nombre del país (en inglés)',
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
            onPressed: _fetchUniversities,
            child: const Text('Buscar universidades'),
          ),
          Expanded(
            child: _universities.isEmpty
                ? const Center(child: Text('Ingrese un país para buscar'))
                : ListView.builder(
                    itemCount: _universities.length,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(_universities[index].name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dominio: ${_universities[index].domain}'),
                            Text(
                              'Página web: ${_universities[index].webPage}',
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.open_in_new),
                          onPressed: () => _launchUrl(
                            Uri.parse(_universities[index].webPage),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}