part of 'news_cubit.dart';

@immutable
abstract class NewsState {
  const NewsState();
}

class NewsInitial extends NewsState {
  const NewsInitial();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoaded extends NewsState {
  final List<NewsItem> news;
  const NewsLoaded(this.news);
}

class NewsViewed extends NewsState {

  final List<NewsItem> news;
  const NewsViewed(this.news);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is NewsViewed && o.news == news;
  }

  @override
  int get hashCode => news.hashCode;
}

class NewsError extends NewsState {
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