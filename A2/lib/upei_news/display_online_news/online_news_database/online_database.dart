import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../fakeNews/model/news_item.dart';
import '../../database/news_item_adapter.dart';


class UnOpenedDBException implements Exception { }

class OnlineNewsDataBase {
  static const String dbName = "OnlineNews";
  late final Box box;

  OnlineNewsDataBase({box}):this.box =box?? Hive.box<NewsItem>(dbName){
    if (!this.box.isOpen){
      throw UnOpenedDBException();
    }
  }

  void put(List<NewsItem> item){
    for(var i = 0; i < item.length; i++) {
      box.put(i, item[i]);
    }
  }

  List<NewsItem> getOfflineNews() {
    List<NewsItem> oln =<NewsItem> [];
    for (var i = 0; i < box.length; i++) {
      oln.add(box.get(i));
    }
    return oln;
  }

  void deleteItem(NewsItem newsItem){
    var i = 0;
    for(i = 0; i < box.length; i++){
      if(box.get(i).title == newsItem.title){
        if(newsItem.date == box.get(i).date){
          box.delete(i);
          break;
        }
      }
    }

    for(var j = i; j < box.length; j++){
      NewsItem temp = box.get(j+1);
      box.delete(j+1);
      box.put(j,temp);
    }
  }

  void update(List<NewsItem> newsItem){

    for(var i = 0; i < box.length; i++){
      box.delete(i);
    }

    for(var i = 0; i < newsItem.length; i++) {
      box.put(i,newsItem[i]);
    }
  }

  static Future<void> init() async {
    Hive.registerAdapter(NewsItemAdapter());

    await Hive.initFlutter();
    await Hive.openBox<NewsItem>(dbName);
  }

  static Future<void> close() async {
    await Hive.close();
  }
}