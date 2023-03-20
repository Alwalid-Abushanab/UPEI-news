import 'dart:math';

import 'package:a1_fakenews/fakeNews/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../news_database.dart';
part 'offline_news_state.dart';

class OfflineNewsCubit extends Cubit<OfflineNewsState>{

  NewsDataBase db;

  OfflineNewsCubit(this.db) : super(OfflineNewsState()) {
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    emit(state.copyWith(status:NewsStatus.loading));
    List<NewsItem> items = db.getOfflineNews();
    emit(state.copyWith(status:NewsStatus.loaded, item: items));
  }


  //update the leaderboard
  void newsList(NewsItem newsItem) {

    List<NewsItem> news = []..addAll(state.item);
    news.add(newsItem);

    emit(state.copyWith(item: news));
    db.put(news);
    _fetchNews();
  }

  void update(List<NewsItem> news) {
    db.update(news);
    _fetchNews();
  }

  void delete(NewsItem newsItem){
    db.deleteItem(newsItem);
    _fetchNews();
  }
}
