import 'package:flutter/material.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/data/news.dart';
import 'package:flutternews/components/article.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({required this.category});

  @override
  _CategoryNews createState() => _CategoryNews();
}

class _CategoryNews extends State<CategoryNews> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass news = CategoryNewsClass();
    await news.getNews(widget.category);
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

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
        body: _loading
            ? Center(
                child: Container(
                child: CircularProgressIndicator(),
              ))
            : SingleChildScrollView(
                child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                        padding:
                            const EdgeInsets.only(top: 5, left: 16, right: 16),
                        child: ListView.builder(
                            itemCount: articles.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlogPost(
                                imageUrl: articles[index].imageUrl,
                                title: articles[index].title,
                                desc: articles[index].description,
                                url: articles[index].url,
                              );
                            }))
                  ],
                ),
              )));
  }
}

class BlogPost extends StatelessWidget {
  final imageUrl, title, desc, url;
  const BlogPost(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticleView(articleUrl: url)));
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl)),
              const SizedBox(height: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500)),
              Text(desc,
                  style: const TextStyle(
                      color: Colors.black54, fontFamily: 'Montserrat')),
            ])));
  }
}
