import 'package:covid_pandemic/core/constants/palette.dart';
import 'package:covid_pandemic/data/models/news.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final Article article;
  const WebViewScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Palette.primaryColor,
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: article.url,
        ),
      ),
    );
  }
}
