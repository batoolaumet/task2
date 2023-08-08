class NewsArticle {
  final String id;
  final String type;
  final String sectionId;
  final String sectionName;
  final String webPublicationDate;
  final String webTitle;
  final String webUrl;
  final String apiUrl;
  final Map<String, dynamic> fields;
  final List<Map<String, dynamic>> tags;
  final bool isHosted;
  final String pillarId;
  final String pillarName;

  NewsArticle({
    required this.id,
    required this.type,
    required this.sectionId,
    required this.sectionName,
    required this.webPublicationDate,
    required this.webTitle,
    required this.webUrl,
    required this.apiUrl,
    required this.fields,
    required this.tags,
    required this.isHosted,
    required this.pillarId,
    required this.pillarName,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'],
      type: json['type'],
      sectionId: json['sectionId'],
      sectionName: json['sectionName'],
      webPublicationDate: json['webPublicationDate'],
      webTitle: json['webTitle'],
      webUrl: json['webUrl'],
      apiUrl: json['apiUrl'],
      fields: json['fields'],
      tags: List<Map<String, dynamic>>.from(json['tags']),
      isHosted: json['isHosted'],
      pillarId: json['pillarId'],
      pillarName: json['pillarName'],
    );
  }
}
