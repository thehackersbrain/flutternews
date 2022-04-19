import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class ArticleView extends StatefulWidget {
  final String articleUrl;
  ArticleView({required this.articleUrl});
  @override
  _ArticleView createState() => _ArticleView();
}

class _ArticleView extends State<ArticleView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Flutter", style: TextStyle(fontFamily: 'Poppins')),
                Text("News",
                    style: TextStyle(color: Colors.blue, fontFamily: 'Poppins'))
              ]),
          actions: <Widget>[
            Opacity(
              opacity: 0,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.save)),
            )
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
//        body: Container(child: const Center(child: Text("This is Test View")))
        body: Container(
            child: WebView(
          initialUrl: widget.articleUrl,
          onWebViewCreated: ((WebViewController webViewController) {
            _completer.complete(webViewController);
          }),
        )));
  }
}
