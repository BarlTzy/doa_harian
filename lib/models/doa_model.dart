class Doa {
  final int id;
  final String title;
  final String arabic;
  final String latin;
  final String translation;

  Doa({
    required this.id,
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
  });

  factory Doa.fromJson(Map<String, dynamic> json) {
    return Doa(
      id: json['id'] ?? 0,
      title: json['doa'] ?? '',
      arabic: json['ayat'] ?? '',
      latin: json['latin'] ?? '',
      translation: json['artinya'] ?? '',
    );
  }
}
