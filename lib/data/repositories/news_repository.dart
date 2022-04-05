import 'package:covid_pandemic/data/dataProviders/news_services.dart';
import 'package:covid_pandemic/data/models/news.dart';
import 'package:flutter/foundation.dart';

class NewsRepository {
  NewsServices newsServices = NewsServices();
  Future<List<Article>> getNewsByCategory(String category) async {
    Map<String, dynamic> response =
        await newsServices.fetchNewsByCategory(category);
    return compute(parseArticles, response);
  }
}

List<Article> parseArticles(Map<String, dynamic> map) {
  return News.fromJson(map).articles;
}
