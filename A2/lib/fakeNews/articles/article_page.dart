import 'package:a1_fakenews/fakeNews/model/model.dart';
import 'package:flutter/material.dart';
import 'article_view.dart';

class ArticlePage extends StatelessWidget{
  const ArticlePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //get the news article that was selected
    final news = ModalRoute.of(context)!.settings.arguments as NewsItem;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("FakeNews"),
      ),
      body: ArticleView(newsData: news,),
    );
  }
}