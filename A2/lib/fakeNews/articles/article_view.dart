import 'package:flutter/cupertino.dart';

import '../../fakeNews/model/news_item.dart';

class ArticleView extends StatelessWidget {
  final NewsItem newsData;

  const ArticleView({required this.newsData});

  @override
  Widget build(BuildContext context) {
    //display the content of the news Article
    return ListView(
      children: <Widget>[
        Image.network(newsData.image, width: 400, height: 400,),
        Center(child: Text(newsData.title, textScaleFactor: 2, textAlign: TextAlign.center,)),
        const SizedBox(height: 30,),
        Center(child:Text(newsData.author)),
        const SizedBox(height: 20,),
        Center(child:Text(newsData.date.year.toString() + "/" + newsData.date.month.toString() + "/" + newsData.date.day.toString())),
        const SizedBox(height: 50,),
        Center(child:Text(newsData.body, textScaleFactor: 1.5, textAlign: TextAlign.center,)),
      ],
    );
  }

}