///News Generator
import 'package:a1_fakenews/fakeNews/model/news_item.dart';

///Source the news
abstract class NewsSourcer {

  ///Retrieve a List of NewsItems
  Future<List<NewsItem>> getNews();

}

class NetworkException implements Exception {}