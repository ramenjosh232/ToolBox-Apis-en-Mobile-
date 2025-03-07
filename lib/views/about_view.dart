import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de Mí')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/my_photo.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Joshua Fermin',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Desarrollador Del ITLA',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            _buildContactButton(
              icon: Icons.email,
              label: 'joshuafermin6@gmail.com',
              onTap: () => _launchUrl('mailto:joshuafermin6@gmail.com'), // Quita el espacio después de mailto:
            ),
            _buildContactButton(
              icon: Icons.phone,
              label: '+1 809-804-8866', // Formato internacional correcto
              onTap: () => _launchUrl('tel:+18098048866'),
            ),
            _buildContactButton(
              icon: Icons.link,
              label: 'Visita mi portafolio',
              onTap: () => _launchUrl('https://github.com/joshuafermin'), // Actualiza con tu URL real
            ),
            const Spacer(),
            const Text(
              '© 2025 Todos los derechos reservados',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      onTap: onTap,
      hoverColor: Colors.blue.withOpacity(0.1),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo lanzar $url';
    }
  }
}