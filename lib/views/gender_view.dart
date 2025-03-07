import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/gender_card.dart'; // Importa el widget

class GenderView extends StatefulWidget {
  @override
  _GenderViewState createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
  final _controller = TextEditingController();
  String _gender = '';
  double _probability = 0.0;
  bool _isLoading = false;

  Future<void> _predictGender() async {
    setState(() => _isLoading = true);
    
    try {
      final response = await http.get(
        Uri.parse('https://api.genderize.io/?name=${_controller.text}'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _gender = data['gender'] ?? '';
          _probability = (data['probability'] ?? 0.0).toDouble();
        });
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predecir Género')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingrese nombre',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _predictGender,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator(),
            if (_gender.isNotEmpty)
              GenderCard(
                gender: _gender,
                probability: _probability,
              ),
          ],
        ),
      ),
    );
  }
}