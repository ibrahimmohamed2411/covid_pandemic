class News {
  News({
    this.status,
    this.totalResults,
    required this.articles,
  });

  String? status;
  int? totalResults;
  List<Article> articles;

  factory News.fromJson(Map<String, dynamic> json) => News(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
          json["articles"].map(
            (x) => Article.fromJson(x),
          ),
        ),
      );
}

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] ?? "author",
        title: json["title"] ?? 'title',
        description: json["description"] ?? 'description',
        url: json["url"] ?? 'url',
        urlToImage: json["urlToImage"] ?? 'urlToImage',
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? 'content',
      );
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] ?? 'id',
        name: json["name"] ?? 'name',
      );
}
