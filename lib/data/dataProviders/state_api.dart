import 'dart:convert';

import 'package:http/http.dart' as http;

const _apiKey = '1745cd71bf1d4c90974a31cde00fa7b1';

class StateApi {
  final http.Client _httpClient = http.Client();

  static final instance = StateApi._init();
  StateApi._init();

  //get the articles from the api as list
  Future<Map<String, dynamic>> fetchStateInformation(
      {required String stateCode}) async {
    final response =
        await _httpClient.get(Uri.parse('https://api.covidactnow.org/'
            'v2/'
            'state/'
            '$stateCode.timeseries.json?'
            'apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      //TODO:
      final body = json.decode(response.body);
      return body;
    }
    throw Exception('Error fetching data');
  }

  void dispose() {
    _httpClient.close();
  }
}
