class News {
  final String title;
  final String summary;
  final String url;

  News({
    required this.title,
    required this.summary,
    required this.url,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title']['rendered'] ?? 'Sin título',
      summary: _parseSummary(json['excerpt']['rendered']),
      url: json['link'] ?? '',
    );
  }

  static String _parseSummary(String htmlString) {
    return htmlString
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&#8230;', '...')
        .trim();
  }
}