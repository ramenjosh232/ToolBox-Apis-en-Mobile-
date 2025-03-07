class University {
  final String name;
  final String domain;
  final String webPage;

  University({required this.name, required this.domain, required this.webPage});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      domain: json['domains'][0],
      webPage: json['web_pages'][0],
    );
  }
}