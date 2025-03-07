class Pokemon {
  final String name;
  final int baseExperience;
  final String imageUrl;
  final List<String> abilities;

  Pokemon({
    required this.name,
    required this.baseExperience,
    required this.imageUrl,
    required this.abilities,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] ?? 'Desconocido',
      baseExperience: json['base_experience'] ?? 0,
      imageUrl: json['sprites']['front_default'] ?? '',
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'].toString())
          .toList(),
    );
  }
}