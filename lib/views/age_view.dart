import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/age.dart';
import '../widgets/age_card.dart';

class AgeView extends StatefulWidget {
  @override
  _AgeViewState createState() => _AgeViewState();
}

class _AgeViewState extends State<AgeView> {
  final _controller = TextEditingController();
  Age? _ageData;
  bool _loading = false;
  String _error = '';

  Future<void> _estimateAge() async {
    setState(() {
      _loading = true;
      _error = '';
    });

    try {
      final response = await http.get(Uri.parse(
          'https://api.agify.io/?name=${_controller.text.trim()}'));
          
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['age'] != null) {
          setState(() => _ageData = Age.fromJson(data));
        } else {
          setState(() => _error = 'Nombre no encontrado');
        }
      }
    } catch (e) {
      setState(() => _error = 'Error de conexión');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estimador de Edad')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingrese nombre',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _estimateAge,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (_error.isNotEmpty)
              Text(_error, style: TextStyle(color: Colors.red)),
            if (_ageData != null) AgeCard(ageData: _ageData!),
          ],
        ),
      ),
    );
  }
}