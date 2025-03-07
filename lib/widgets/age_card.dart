import 'package:flutter/material.dart';
import '../models/age.dart';

class AgeCard extends StatelessWidget {
  final Age ageData;

  const AgeCard({super.key, required this.ageData});

  @override
  Widget build(BuildContext context) {
    final colors = {
      'joven': Colors.blue[100]!,
      'adulto': Colors.green[100]!,
      'anciano': Colors.orange[100]!,
    };

    final images = {
      'joven': 'assets/images/young.png',
      'adulto': 'assets/images/adult.png',
      'anciano': 'assets/images/elderly.png',
    };

    return Card(
      color: colors[ageData.category],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(images[ageData.category]!, height: 100),
            const SizedBox(height: 10),
            Text('Edad estimada: ${ageData.age}',
                style: const TextStyle(fontSize: 20)),
            Text('Categoría: ${ageData.category.toUpperCase()}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}