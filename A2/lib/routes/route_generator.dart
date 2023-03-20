import 'package:a1_fakenews/fakeNews/display_news/news_page.dart';
import 'package:a1_fakenews/fakeNews/articles/article_page.dart';
import '../upei_news/display_online_news/upei_news_page.dart';
import '../upei_news/offline_news/offline_news_view.dart';
import 'unknown_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../home/home_page.dart';

class RouteGenerator {

  static const String homePage = '/';
  static const String articlePage = '/articlePage';
  static const String fakeNews = '/fakeNews';
  static const String upeiNews = '/upeiNews';
  static const String offline = '/offlineNews';

  //private constructor
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case articlePage:
        return MaterialPageRoute(
          builder: (_) => const ArticlePage(), settings: settings,
        );
      case fakeNews:
        return MaterialPageRoute(
          builder: (_) => const NewsPage(),
        );
      case upeiNews:
        return MaterialPageRoute(
          builder: (_) => const UpeiNewsPage(),
        );
      case offline:
        return MaterialPageRoute(
          builder: (_) => OfflineNewsView(),
        );
    }
    if(kDebugMode) {
      return MaterialPageRoute(builder: (context) =>  UnknownScreen());
    }
    else {
      return MaterialPageRoute(builder: (context) => HomePage());
    }
  }

}