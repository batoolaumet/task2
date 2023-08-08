class ArticleCategory {
  String id = "";
  String webTitle = "";

  ArticleCategory({required this.id, required this.webTitle});

  ArticleCategory.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    webTitle = data['webTitle'];
  }
}