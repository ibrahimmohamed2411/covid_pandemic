import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:covid_pandemic/core/constants/palette.dart';

class WebView2 extends StatelessWidget {
  final String url;
  const WebView2({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: url,
        ),
      ),
    );
  }
}
