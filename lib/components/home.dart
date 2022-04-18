import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/models/category_model.dart';
import 'package:flutternews/data/data.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/data/news.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<CategoryModel> categories = new List<CategoryModel>();
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNewsArticles();
  }

  getNewsArticles() async {
    News news = News();
    await news.getNews();
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
                Text("Flutter"),
                Text("News", style: TextStyle(color: Colors.blue))
              ]),
          elevation: 0.0,
        ),
        body: _loading
            ? Center(
                child: Container(
                child: const CircularProgressIndicator(),
              ))
            : SingleChildScrollView(
                child: Container(
                // padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    // Category Tabs
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 70,
                        child: ListView.builder(
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                imageUrl: categories[index].imageUrl,
                                categoryName: categories[index].categoryName,
                              );
                            })),
                    // Articles
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
                              );
                            }))
                  ],
                ),
              )));
  }
}

class CategoryCard extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryCard({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            margin: const EdgeInsets.only(right: 16),
            child: Stack(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 120,
                    height: 60,
                    fit: BoxFit.cover),
              ),
              Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black26,
                  ),
                  child: Text(categoryName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )))
            ])));
  }
}

class BlogPost extends StatelessWidget {
  final imageUrl, title, desc;
  const BlogPost(
      {@required this.imageUrl, @required this.title, @required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  fontWeight: FontWeight.w500)),
          Text(desc, style: const TextStyle(color: Colors.black54)),
        ]));
  }
}
