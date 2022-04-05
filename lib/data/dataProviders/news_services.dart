import 'package:covid_pandemic/core/constants/strings.dart';
import 'package:dio/dio.dart';

class NewsServices {
  late Dio dio;
  NewsServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  Future<dynamic> fetchNewsByCategory(String category) async {
    var response = await dio.get(
      category,
      queryParameters: {
        'country': 'us',
        'category': category,
        'apiKey': APIKey,
      },
    );
    return response.data;
  }
}
