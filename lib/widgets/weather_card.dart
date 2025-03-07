import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/weather.dart'; // Importar el modelo correcto

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Clima en República Dominicana',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            CachedNetworkImage(
              imageUrl: 'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
              height: 80,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Text('${weather.temperature.toStringAsFixed(1)}°C',
                style: const TextStyle(fontSize: 24)),
            Text(weather.condition,
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}