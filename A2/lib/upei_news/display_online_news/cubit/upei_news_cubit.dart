import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webfeed/domain/rss_item.dart';

import '../../fetcher/upei_news_source.dart';
import '/fakeNews/model/fetcher/news_gen.dart';
import '/fakeNews/model/news_item.dart';

part 'upei_news_state.dart';

class UpeiNewsCubit extends Cubit<UpeiNewsState> {

  final UPEINewsSource _newsSourcer;

  UpeiNewsCubit(this._newsSourcer) : super(const NewsInitial());

  Future<void> getNews() async {
    bool tryAgain = true;

    //try 3 times to fetch the news
    for (var i = 0; i < 3; i++) {
      try {
        emit(const NewsLoading());
        final news = await _newsSourcer.getNews();
        emit(NewsLoaded(news));
        tryAgain = false;
      } on FormatException {
        tryAgain = true;
      } on RangeError {
        tryAgain = true;
      } on NetworkException {
        emit(const NewsError("Internet Error"));
        tryAgain = true;
      }

      if (!tryAgain) {
        break;
      }
    }
  }

  /// update the news article to be marked as viewed
  void update(List<NewsItem> news) {
    print(state);
    if(state is NewsLoaded) {
      emit(NewsViewed(news));
    }
    else{
      emit(NewsLoaded(news));
    }
    print(state);
  }
}