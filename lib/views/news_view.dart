import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import '../models/news.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List<News> _news = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.get(
          Uri.parse('https://www.wpnoticias.com/wp-json/wp/v2/posts?per_page=3'));

      if (response.statusCode == 200) {
        setState(() {
          _news = (json.decode(response.body) as List)
              .map((newsJson) => News.fromJson(newsJson))
              .toList();
        });
      } else {
        setState(() {
          _errorMessage = 'Error cargando noticias';
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
      appBar: AppBar(title: const Text('Últimas Noticias')),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(child: Text(_errorMessage));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset('assets/images/wordpress_logo.png', height: 80),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: _news.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final newsItem = _news[index];
              return ListTile(
                title: Text(newsItem.title),
                subtitle: Text(newsItem.summary),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () => _launchUrl(newsItem.url),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo abrir el enlace')));
    }
  }
}