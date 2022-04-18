import 'package:flutter/material.dart';
import 'package:flutternews/models/category_model.dart';
import 'package:flutternews/data/data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<CategoryModel> categories = new List<CategoryModel>();
  List<CategoryModel> categories = <CategoryModel>[];

  @override
  void initState() {
    super.initState();
    categories = getCategories();
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
        body: Container(
          child: Column(
            children: <Widget>[
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
                      }))
            ],
          ),
        ));
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
                child: Image.network(imageUrl,
                    width: 120, height: 60, fit: BoxFit.cover),
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
