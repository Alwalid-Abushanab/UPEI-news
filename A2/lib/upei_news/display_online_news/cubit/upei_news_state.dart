part of 'upei_news_cubit.dart';

@immutable
abstract class UpeiNewsState {
  const UpeiNewsState();
}

class NewsInitial extends UpeiNewsState {
  const NewsInitial();
}

class NewsLoading extends UpeiNewsState {
  const NewsLoading();
}

class NewsLoaded extends UpeiNewsState {
  final List<NewsItem> news;
  const NewsLoaded(this.news);
}

class NewsViewed extends UpeiNewsState {

  final List<NewsItem> news;
  const NewsViewed(this.news);
}

class NewsError extends UpeiNewsState {
  final String message;
  const NewsError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NewsError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}