import 'package:flutternews/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    var apiUrl = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=d86f01e6eccd4844ad5c8ef7021b5d6e');
    var response = await http.get(apiUrl);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    // var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            imageUrl: element['urlToImage'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}
