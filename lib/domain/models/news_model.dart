class NewsModel {
  late String title;
  late String url;
  late String urlToImage;
  late String publishedAt;

  NewsModel(
      {required this.title,
      required this.url,
      required this.urlToImage,
      required this.publishedAt});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
    };
  }

  NewsModel.fromMap(Map<String, dynamic> map) {
    title = map['title'] ?? '';
    url = map['url'] ?? '';
    urlToImage = map['urlToImage'] ?? '';
    publishedAt = map['publishedAt'] ?? '';
  }
}
