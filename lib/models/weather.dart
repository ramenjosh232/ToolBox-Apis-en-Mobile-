class Weather {
  final double temperature;
  final String condition;
  final String icon;

  const Weather({
    required this.temperature,
    required this.condition,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather = json['weather'][0];
    
    return Weather(
      temperature: (main['temp'] as num).toDouble(),
      condition: weather['description'],
      icon: weather['icon'],
    );
  }
}