import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  final String gender;
  final double probability;

  const GenderCard({
    super.key,
    required this.gender,
    required this.probability,
  });

  @override
  Widget build(BuildContext context) {
    final color = gender == 'male' ? Colors.blue : Colors.pink;
    final icon = gender == 'male' ? Icons.male : Icons.female;

    return Card(
      color: color.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(icon, size: 100, color: color),
            const SizedBox(height: 20),
            Text(
              'Género: ${gender == 'male' ? 'Masculino' : 'Femenino'}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Probabilidad: ${(probability * 100).toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}