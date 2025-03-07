class Age {
  final String name;
  final int age;
  final String category;

  Age({
    required this.name,
    required this.age,
    required this.category,
  });

  factory Age.fromJson(Map<String, dynamic> json) {
    final ageValue = json['age'] ?? 0;
    return Age(
      name: json['name'] ?? '',
      age: ageValue,
      category: _determineCategory(ageValue),
    );
  }

  static String _determineCategory(int age) {
    if (age < 18) return 'joven';
    if (age < 65) return 'adulto';
    return 'anciano';
  }
}